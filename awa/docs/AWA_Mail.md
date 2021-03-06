# Mail Module
The `AWA.Mail` module allows an application to format and send a mail
to users.  This module does not define any web interface.  It provides
a set of services and methods to send a mail when an event is
received.  All this is done through configuration.  The module
defines a set of specific ASF components to format and prepare the
email.

## Configuration
The *mail* module needs some properties to configure the SMTP
server.

|Configuration    | Default   | Description                                     |
| --------------- | --------- | ----------------------------------------------- |
|mail.smtp.host   | localhost | Defines the SMTP server host name               |
|mail.smtp.port   | 25        | Defines the SMTP connection port                |
|mail.smtp.enable | 1         | Defines whether sending email is enabled or not |

## Sending an email
Sending an email when an event is posted can be done by using
an XML configuration.  Basically, the *mail* module uses the event
framework provided by AWA.  The XML definition looks like:

```Ada
<on-event name="user-register">
  <action>#{userMail.send}</action>
  <property name="template">/mail/register-user-message.xhtml</property>
</on-event>
```

With this definition, the mail template `/mail/register-user-message.xhtml`
is formatted by using the event and application context when the
`user-register` event is posted.

## Components
The <b>AWA.Mail.Components</b> package defines several UI components that represent
a mail message in an ASF view.  The components allow the creation, formatting and
sending of a mail message using the same mechanism as the application presentation layer.
Example:

```Ada
<f:view xmlns="mail:http://code.google.com/p/ada-awa/mail">
  <mail:message>
    <mail:subject>Welcome</mail:subject>
    <mail:to name="Iorek Byrnison">Iorek.Byrnison@svalbard.com</mail:to>
    <mail:body>
        ...
    </mail:body>
  </mail:message>
</f:view>
```

When the view which contains these components is rendered, a mail message is built
and initialized by rendering the inner components.  The body and other components can use
other application UI components to render useful content.  The email is send after
the <b>mail:message</b> has finished to render its inner children.

The <b>mail:subject</b> component describes the mail subject.

The <b>mail:to</b> component define the mail recipient.  There can be several recepients.

The <b>mail:body</b> component contains the mail body.

### Mail Recipients
The <b>AWA.Mail.Components.Recipients</b> package defines the UI components
to represent the <tt>To</tt>, <tt>From</tt>, <tt>Cc</tt> and <tt>Bcc</tt> recipients.

The mail message is retrieved by looking at the parent UI component until a
`UIMailMessage` component is found.  The mail message recipients are initialized
during the render response JSF phase, that is when <tt>Encode_End</tt> are called.

### Mail Messages
The <b>AWA.Mail.Components.Messages</b> package defines the UI components
to represent the email message with its recipients, subject and body.

The mail message is retrieved by looking at the parent UI component until a
<tt>UIMailMessage</tt> component is found.  The mail message recipients are initialized
during the render response JSF phase, that is when <tt>Encode_End</tt> are called.


## Ada Beans


| Name           | Description                                                               |
| Name           | Description                                                               |
|:---------------|:--------------------------------------------------------------------------|
|:---------------|:--------------------------------------------------------------------------|
|userMail|Bean used to send an email with a specific template to the user.|
|userMail|Bean used to send an email with a specific template to the user.|


### Configuration
| Name                      | Description                                                    |
|:--------------------------|:---------------------------------------------------------------|
|openid.realm|The REALM URL used by OpenID providers to verify the validity of the verification callback.|
| |http://localhost:8080#{contextPath}/auth|





