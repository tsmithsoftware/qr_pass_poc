# QR Code POC
## Overview
The aim of this project is a POC of a project using a QR code to validate passes issued on a central database. There are two devices involved in this POC - the "visitor" device holding the QR code and the "store" device validating the code.

### Project Requirements
#### Non-functional requirements
1. The project should be built in Flutter.
2. The project should include an API definition written in Wiremock.
3. The project should contain a definition of how the communication between the visitor's device and the server should work.
4. The project should contain a definition of how the communication between the store device and the server should work.
5. A method of security does not need to be implemented, due to the pass returning images. This was specified by the client.

#### Functional requirements
1. The project should have POC "store" functionality. This is a client that will scan a presented QR code, communicate securely with an API, and return the following information:
<li/>The Pass ID
<li/>A link to an image, preferably in blob storage
<li/> The pass category
<li/> The pass number
<li/> The name of the associated visitor
The store user would see the name, image, the pass category and pass number and use this to validate the pass.
2. The project should have POC "client" functionality. This is a client that will communicate with a server and download a set of passes that can be displayed. It should be possible to organise this set by date and store, although I don't think this is included the first release.
