# Hair4You

## Description
An open-source project for small-business hairdressers needing an webapplication.
The application will handle the following features: 

* Login with standard email and password or through Facebook/Google,
* Link and Unlink facebook/Google,
* Bookings, 
* User-profiles, 
* Notifications,
* Store pictures of customers hairdress,
* Dynamic frontpage and 
* Dynamic pricing. 

## Features
The features that will be developed.

### Login and (link & unlink)
The login page will be at /login and if the user want to login through Facebook/Google then /login/{facebook/Google}.
If the user choose Facebook as login a account will be created assoicating it with Facebook. 
A user can at anytime link and unlink Facebook/Google.

### Bookings
Bookings are handled through the /booking page, which the hairdresser can assign available time-slots.
Customers can book the available time-slots.
Each time slot will be have its own page at /booking/{booking.id} 

### User-profiles
The customer has their own page at /{user.id}/profile which the hairdresser can update their hairstyles with pictures. The customer and the hairdresser can highlight the styles they think fits the best. Making it easier for the hairdresser to recreate it at the next visit. 

### Notifications
The customer and the hairdresser get notified either through mail or at the page. 
The web-admin/owner can set a preffered alert time. Both the customer and the hairdresser can choose to ignore notifications.

### Dynamic frontpage
The web-admin/owner can dynamically update the information at the frontpage with a user-firendly interface. It can be used as for example an blog. 
For instance the onwer can with the customers agreement make pictures public on the frontpage. 

### Dynamic pricing
The web-admin/owner can dynamically update the pricing with a user-frendly interface whenever needed. 

## Technical
The project are based on the programming language Dart which is separated with a frontend and backend. 
The purpose of using the same programming is to benefit modeling as both the frameworks can share the same models file. 

### Frontend
The frontend framework that will be used is [Flutter 2.0](https://flutter.dev/) which has recently been released for production. This can be risky as all documentation is not finnished. 
A feature with this framwork is the simplicity to adapt the code for multiplatform useage. Like releasing on Ios, Android and the web.

See [Frontend readme](https://gitlab.liu.se/josat799/tddd27/-/blob/master/frontend/README.md) for more information on frontend setup and requirements.

### Backend
The backend or application will use the [Aqueduct](https://aqueduct.io/) framework. The framework is pretty unused and currently has a low rating. However it is well documented and supports integrations for PostgresSql and OAuth2.

See [Backend readme](https://gitlab.liu.se/josat799/tddd27/-/blob/master/backend/README.md) for more information on backend setup and requirements.

<mark>After some research the framework has shown to be unsupported with the latests DART-SDK making it unstable and unreliable. In this case the DART-SDK 2.7.2 is the most stable version.</mark>

I choose this framework also because normally you will be thrown into new frameworks that you have not used earlier because the company started that way. However if the framework stops working or get to unsopported I will change, either, node.js or FLASK. 

#### Database and media storeage
The database that will be used is PostgresSql V.12 and all media (such as images) will be stored on site.

## Workflow
At the begining the branches frontend-development, backend-development and testing will be used for creating the and setting everything up.

After the initial setup is done feature branching will be applied to add new features.

## Setup
See [Backend readme](https://gitlab.liu.se/josat799/tddd27/-/blob/master/backend/README.md) and [Frontend readme](https://gitlab.liu.se/josat799/tddd27/-/blob/master/frontend/README.md) for more information on frontend and backend setups.

Primairly for backend you will need DART-SDK: 2.7.2.
Primairly for frontend you will need the latest DART-SDK togheter with FLutter 2.0.
Primairly for the database you will need PostgesSQL 12.

## Links and miscellaneous
### Mid-Course Presentation
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/sGXtVhGQlbA/0.jpg)](https://www.youtube.com/watch?v=sGXtVhGQlbA)


