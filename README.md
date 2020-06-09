# Elder Helper Site For Offering Service / Requesting Service For Elders

## Prerequisites

Clojure, Leiningen, MySQL

## Setup

In MySQL create a database called *elderhelper*

```
CREATE DATABASE elderhelper DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
```

Change user/pass in db-config.edn and in migratus.conf.edn

Create & Fill up database with

```
lein migratus migrate
```

## Startup

```
lein ring server
```

## Used Libraries

- Leiningen : Project automation tool with declarative configuration
- Ring : Web Applications Library
- Migratus : General migration framework
- Compojure: Compojure is a small routing library for Ring that allows web applications to be composed of small, independent parts.
- Korma : SQL query library
- Hiccup : Library for representing HTML in Clojure 
- Buddy auth : Authentication and Authorization library

## Project description

Elder Helper is a website where users can offer services and accept services.

There are two types of users : admins and simple users.

Admins can add new users and delete existing users.

Simple users can create new offers and new requests and can reserve services, apply for requests, create new offers and create new requests.

For simple users the available menu items are : Schedules/Your Offers/Your Requests/Logout

For admins available menu items are : Schedules/Users/Logout