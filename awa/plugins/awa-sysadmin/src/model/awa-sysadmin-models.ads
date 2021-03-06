-----------------------------------------------------------------------
--  AWA.Sysadmin.Models -- AWA.Sysadmin.Models
-----------------------------------------------------------------------
--  File generated by ada-gen DO NOT MODIFY
--  Template used: templates/model/package-spec.xhtml
--  Ada Generator: https://ada-gen.googlecode.com/svn/trunk Revision 1095
-----------------------------------------------------------------------
--  Copyright (C) 2019 Stephane Carrez
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
pragma Warnings (Off);
with ADO.Sessions;
with ADO.Objects;
with ADO.Statements;
with ADO.SQL;
with ADO.Schemas;
with ADO.Queries;
with ADO.Queries.Loaders;
with Ada.Calendar;
with Ada.Containers.Vectors;
with Ada.Strings.Unbounded;
with Util.Beans.Objects;
with Util.Beans.Basic.Lists;
with Util.Beans.Methods;
pragma Warnings (On);
package AWA.Sysadmin.Models is

   pragma Style_Checks ("-mr");


   --  --------------------
   --    The information about a wiki page.
   --  --------------------
   type User_Info is
     new Util.Beans.Basic.Bean with  record

      --  the user page identifier.
      Id : ADO.Identifier;

      --  the wiki page name.
      Name : Ada.Strings.Unbounded.Unbounded_String;

      --  the wiki page title.
      Title : Ada.Strings.Unbounded.Unbounded_String;

      --  whether the wiki is public.
      Is_Public : Boolean;

      --  the last version.
      Last_Version : Integer;

      --  the read count.
      Read_Count : Integer;

      --  the wiki creation date.
      Create_Date : Ada.Calendar.Time;

      --  the wiki page author.
      Author : Ada.Strings.Unbounded.Unbounded_String;
   end record;

   --  Get the bean attribute identified by the name.
   overriding
   function Get_Value (From : in User_Info;
                       Name : in String) return Util.Beans.Objects.Object;

   --  Set the bean attribute identified by the name.
   overriding
   procedure Set_Value (Item  : in out User_Info;
                        Name  : in String;
                        Value : in Util.Beans.Objects.Object);


   package User_Info_Beans is
      new Util.Beans.Basic.Lists (Element_Type => User_Info);
   package User_Info_Vectors renames User_Info_Beans.Vectors;
   subtype User_Info_List_Bean is User_Info_Beans.List_Bean;

   type User_Info_List_Bean_Access is access all User_Info_List_Bean;

   --  Run the query controlled by <b>Context</b> and append the list in <b>Object</b>.
   procedure List (Object  : in out User_Info_List_Bean'Class;
                   Session : in out ADO.Sessions.Session'Class;
                   Context : in out ADO.Queries.Context'Class);

   subtype User_Info_Vector is User_Info_Vectors.Vector;

   --  Run the query controlled by <b>Context</b> and append the list in <b>Object</b>.
   procedure List (Object  : in out User_Info_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Context : in out ADO.Queries.Context'Class);

   Query_Sysadmin_User_List : constant ADO.Queries.Query_Definition_Access;


   --  --------------------
   --    authenticate the sysadmin user
   --  --------------------
   type Authenticate_Bean is abstract limited
     new Util.Beans.Basic.Bean and Util.Beans.Methods.Method_Bean with  record

      --  the password.
      Password : Ada.Strings.Unbounded.Unbounded_String;
   end record;

   --  This bean provides some methods that can be used in a Method_Expression.
   overriding
   function Get_Method_Bindings (From : in Authenticate_Bean)
                                 return Util.Beans.Methods.Method_Binding_Array_Access;

   --  Get the bean attribute identified by the name.
   overriding
   function Get_Value (From : in Authenticate_Bean;
                       Name : in String) return Util.Beans.Objects.Object;

   --  Set the bean attribute identified by the name.
   overriding
   procedure Set_Value (Item  : in out Authenticate_Bean;
                        Name  : in String;
                        Value : in Util.Beans.Objects.Object);

   procedure Authenticate (Bean : in out Authenticate_Bean;
                          Outcome : in out Ada.Strings.Unbounded.Unbounded_String) is abstract;


private

   package File_1 is
      new ADO.Queries.Loaders.File (Path => "sysadmin-users.xml",
                                    Sha1 => "54186E969C872FD5295A3FA31BA701F514B38284");

   package Def_Userinfo_Sysadmin_User_List is
      new ADO.Queries.Loaders.Query (Name => "sysadmin-user-list",
                                     File => File_1.File'Access);
   Query_Sysadmin_User_List : constant ADO.Queries.Query_Definition_Access
   := Def_Userinfo_Sysadmin_User_List.Query'Access;
end AWA.Sysadmin.Models;
