-----------------------------------------------------------------------
--  awa -- Ada Web Application
--  Copyright (C) 2009, 2010, 2011, 2012, 2013, 2015, 2018 Stephane Carrez
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

--  = AWA Core ==
--
--  @include awa-modules.ads
--  @include awa-permissions.ads
--  @include awa-events.ads
--  @include awa.xml
package AWA is

   pragma Pure;

   --  Library SVN identification
   SVN_URL : constant String := "$HeadURL: file:///opt/repository/svn/ada/awa/trunk/src/awa.ads $";

   --  Revision used (must run 'make version' to update)
   SVN_REV : constant String := "$Rev: 318 $";

end AWA;
