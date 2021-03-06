-----------------------------------------------------------------------
--  awa-blogs -- Blogs module
--  Copyright (C) 2011, 2014, 2015, 2018 Stephane Carrez
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

--  = Blogs Module =
--  The `blogs` module is a small blog application which allows users to publish articles.
--  A user may own several blogs, each blog having a name and its own base URI.  Within a blog,
--  the user may write articles and publish them.  Once published, the articles are visible to
--  anonymous users.
--
--  The `blogs` module uses the [AWA_Tags] and [AWA_Comments] modules to allow to associate
--  tags to a post and allow users to comment on the articles.
--
--  @include awa-blogs-modules.ads
--
--  @include awa-blogs-beans.ads
--  @include-bean blogs.xml
--  @include-bean blog-admin-post-list.xml
--  @include-bean blog-post-list.xml
--  @include-bean blog-comment-list.xml
--  @include-bean blog-list.xml
--  @include-bean blog-tags.xml
--
--  == Queries ==
--  @include-query blog-admin-post-list.xml
--  @include-query blog-post-list.xml
--  @include-query blog-comment-list.xml
--  @include-query blog-list.xml
--  @include-query blog-tags.xml
--
--  == Data model ==
--  [images/awa_blogs_model.png]
--
package AWA.Blogs is

   pragma Pure;

end AWA.Blogs;
