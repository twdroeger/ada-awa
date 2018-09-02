/* File generated automatically by dynamo */
/*  */
CREATE TABLE awa_blog (
  /* the blog identifier */
  "id" BIGINT NOT NULL,
  /* the blog name */
  "name" VARCHAR(255) NOT NULL,
  /* the version */
  "version" INTEGER NOT NULL,
  /* the blog uuid */
  "uid" VARCHAR(255) NOT NULL,
  /* the blog creation date */
  "create_date" TIMESTAMP NOT NULL,
  /* the date when the blog was updated */
  "update_date" TIMESTAMP NOT NULL,
  /* The blog base URL. */
  "url" VARCHAR(255) NOT NULL,
  /* the workspace that this blog belongs to */
  "workspace_id" BIGINT NOT NULL,
  PRIMARY KEY ("id")
);
/*  */
CREATE TABLE awa_post (
  /* the post identifier */
  "id" BIGINT NOT NULL,
  /* the post title */
  "title" VARCHAR(255) NOT NULL,
  /* the post text content */
  "text" TEXT NOT NULL,
  /* the post creation date */
  "create_date" TIMESTAMP NOT NULL,
  /* the post URI */
  "uri" VARCHAR(255) NOT NULL,
  /*  */
  "version" INTEGER NOT NULL,
  /* the post publication date */
  "publish_date" TIMESTAMP ,
  /* the post status */
  "status" SMALLINT NOT NULL,
  /*  */
  "allow_comments" BOOLEAN NOT NULL,
  /* the number of times the post was read. */
  "read_count" INTEGER NOT NULL,
  /*  */
  "author_id" BIGINT NOT NULL,
  /*  */
  "blog_id" BIGINT NOT NULL,
  PRIMARY KEY ("id")
);
INSERT INTO entity_type (name) VALUES
('awa_blog')
,('awa_post')
;
