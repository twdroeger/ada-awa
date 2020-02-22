-----------------------------------------------------------------------
--  awa-commands-start -- Command to start the web server
--  Copyright (C) 2020 Stephane Carrez
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--
--  Licensed under the Apache License, Version 2.0 (the "License");
--  you may not use this file except in compliance with the License.
--  You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
--  Unless required by applicable law or agreed to in writing, software
--  distributed under the License is distributed on an "AS IS" BASIS,
--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--  See the License for the specific language governing permissions and
--  limitations under the License.
-----------------------------------------------------------------------
with Servlet.Core;
with Servlet.Server;
with GNAT.Sockets;
with AWA.Applications;
package body AWA.Commands.Start is

   use Ada.Strings.Unbounded;

   --  ------------------------------
   --  Start the server and all the application that have been registered.
   --  ------------------------------
   overriding
   procedure Execute (Command   : in out Command_Type;
                      Name      : in String;
                      Args      : in Argument_List'Class;
                      Context   : in out Context_Type) is
      procedure Configure (URI : in String;
                           Application : in Servlet.Core.Servlet_Registry_Access);
      procedure Shutdown (URI : in String;
                          Application : in Servlet.Core.Servlet_Registry_Access);

      Count : Natural := 0;

      procedure Configure (URI : in String;
                           Application : in Servlet.Core.Servlet_Registry_Access) is
      begin
         if Application.all in AWA.Applications.Application'Class then
            Configure (AWA.Applications.Application'Class (Application.all),
                       URI (URI'First + 1 .. URI'Last),
                       Context);
            Count := Count + 1;
         end if;
      end Configure;

      procedure Shutdown (URI : in String;
                          Application : in Servlet.Core.Servlet_Registry_Access) is
      begin
         if Application.all in AWA.Applications.Application'Class then
            AWA.Applications.Application'Class (Application.all).Close;
         end if;
      end Shutdown;

      Config  : Servlet.Server.Configuration;
      Address : GNAT.Sockets.Sock_Addr_Type;
      Listen  : GNAT.Sockets.Socket_Type;
      Socket  : GNAT.Sockets.Socket_Type;
   begin
      Config.Listening_Port := Command.Listening_Port;
      Config.Max_Connection := Command.Max_Connection;
      Config.TCP_No_Delay := Command.TCP_No_Delay;
      if Command.Upload'Length > 0 then
         Config.Upload_Directory := To_Unbounded_String (Command.Upload.all);
      end if;
      Command_Drivers.WS.Configure (Config);

      Command_Drivers.WS.Iterate (Configure'Access);
      if Count = 0 then
         Context.Console.Error (-("There is no application"));
         return;
      end if;
      Context.Console.Notice (N_INFO, "Starting...");
      Command_Drivers.WS.Start;

      GNAT.Sockets.Create_Socket (Listen);
      Address.Addr := GNAT.Sockets.Loopback_Inet_Addr;
      Address.Port := 0;
      GNAT.Sockets.Bind_Socket (Listen, Address);
      GNAT.Sockets.Listen_Socket (Listen);

      loop
         GNAT.Sockets.Accept_Socket (Listen, Socket, Address);
         exit;
      end loop;
      GNAT.Sockets.Close_Socket (Socket);
      GNAT.Sockets.Close_Socket (Listen);

      Command_Drivers.WS.Iterate (Shutdown'Access);
   end Execute;

   --  ------------------------------
   --  Setup the command before parsing the arguments and executing it.
   --  ------------------------------
   overriding
   procedure Setup (Command : in out Command_Type;
                    Config  : in out GNAT.Command_Line.Command_Line_Configuration;
                    Context : in out Context_Type) is
   begin
      GC.Set_Usage (Config => Config,
                    Usage  => Command.Get_Name & " [arguments]",
                    Help   => Command.Get_Description);
      GC.Define_Switch (Config => Config,
                        Output => Command.Management_Port'Access,
                        Switch => "-m:",
                        Long_Switch => "--management-port=",
                        Initial  => Command.Management_Port,
                        Argument => "NUMBER",
                        Help   => -("The server listening management port on localhost"));
      GC.Define_Switch (Config => Config,
                        Output => Command.Listening_Port'Access,
                        Switch => "-p:",
                        Long_Switch => "--port=",
                        Initial  => Command.Listening_Port,
                        Argument => "NUMBER",
                        Help   => -("The server listening port"));
      GC.Define_Switch (Config => Config,
                        Output => Command.Max_Connection'Access,
                        Switch => "-C:",
                        Long_Switch => "--connection=",
                        Initial  => Command.Max_Connection,
                        Argument => "NUMBER",
                        Help   => -("The number of connections handled"));
      GC.Define_Switch (Config => Config,
                        Output => Command.Upload'Access,
                        Switch => "-u:",
                        Long_Switch => "--upload=",
                        Argument => "PATH",
                        Help   => -("The server upload directory"));
      GC.Define_Switch (Config => Config,
                        Output => Command.TCP_No_Delay'Access,
                        Switch => "-n",
                        Long_Switch => "--tcp-no-delay",
                        Help   => -("Enable the TCP no delay option"));
      AWA.Commands.Setup (Config, Context);
   end Setup;

   --  ------------------------------
   --  Write the help associated with the command.
   --  ------------------------------
   overriding
   procedure Help (Command   : in out Command_Type;
                   Name      : in String;
                   Context   : in out Context_Type) is
      pragma Unreferenced (Command, Context);
   begin
      null;
   end Help;

begin
   Command_Drivers.Driver.Add_Command ("start",
                                       -("start the web server"),
                                       Command'Access);
end AWA.Commands.Start;