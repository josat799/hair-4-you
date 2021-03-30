# Hair4You

## Description
An open-source project for small-business hairdressers needing an webapplication.
The application will handle the following features: 

* Login with standard email and password or through Facebook,
* Link and Unlink facebook
* bookings, 
* user-profiles, 
* notifications, 
* dynamic frontpage and 
* dynamic pricing. 

## Features
The features that will be developed.

### Login and (link & unlink)
The login page will be at /login and if the user want to login through Facebook then /login/facebook.
If the user choose Facebook as login a account will be created assoicating it with Facebook. 
A user can at anytime link and unlink Facebook.

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

### Dynamic pricing
The web-admin/owner can dynamically update the pricing with a user-frendly interface whenever needed. 

## Technical
The project are based on the programming language Dart which is separated with a frontend and backend. 
The purpose of using the same programming is to benefit modeling as both the frameworks can share the same models file. 

### Frontend
The frontend framework that will be used is [Flutter 2.0](https://flutter.dev/) which has recently been released for production. This can be risky as all documentation is not finnished. 
A feature with this framwork is the simplicity to adapt the code for multiplatform useage. Like releasing on Ios, Android and the web.

### Backend
The backend or application will use the [Aqueduct](https://aqueduct.io/) framework. The framework is pretty unused and currently has a low rating. However it is well documented and supports integrations for PostgresSql and OAuth2.

#### Database and media storeage
The database that will be used is PostgresSql and all media (such as images) will be stored on site.

## Workflow
For this project feature branching will be used on the sub branches frontend-development and frontend-development.

All issues will be handled through GitLabs built in tools.

## Setup

## Links and miscellaneous

