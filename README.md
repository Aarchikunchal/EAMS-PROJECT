# 🏭 Enterprise Asset Management System (EAMS)

> A SAP ABAP RESTful Application Programming Model (RAP) based Enterprise Asset Management solution for managing organizational assets, plants, locations, vendors, maintenance services, repairs, and the complete asset maintenance lifecycle.

[![SAP](https://img.shields.io/badge/SAP-RAP-blue)](https://www.sap.com/)
[![ABAP](https://img.shields.io/badge/ABAP-Cloud-orange)](https://www.sap.com/products/technology-platform/abap.html)
[![CDS](https://img.shields.io/badge/CDS-Views-green)](https://www.sap.com/)
[![RAP](https://img.shields.io/badge/RAP-RESTful%20Application%20Programming%20Model-purple)](https://www.sap.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## 📌 Table of Contents

* [Overview](#-overview)
* [Business Problem](#-business-problem)
* [Project Objective](#-project-objective)
* [Business Process](#-business-process)
* [Key Features](#-key-features)
* [Functional Modules](#-functional-modules)
* [Asset Management](#1-asset-management)
* [Plant Management](#2-plant-management)
* [Plant Location Management](#3-plant-location-management)
* [Vendor Management](#4-vendor-management)
* [Service Management](#5-service-management)
* [Repair Management](#6-repair-management)
* [RAP Architecture](#-rap-architecture)
* [Application Architecture](#-application-architecture)
* [Data Model](#-data-model)
* [CDS View Architecture](#-cds-view-architecture)
* [Behavior Definitions](#-behavior-definitions)
* [Validations](#-validations)
* [Determinations](#-determinations)
* [Side Effects](#-side-effects)
* [Value Help](#-value-help)
* [DDIC Objects](#-ddic-objects)
* [Repository Structure](#-repository-structure)
* [Technology Stack](#-technology-stack)
* [Development Environment](#-development-environment)
* [Installation and Setup](#-installation-and-setup)
* [Application Flow](#-application-flow)
* [Business Benefits](#-business-benefits)
* [Future Enhancements](#-future-enhancements)
* [Learning Outcomes](#-learning-outcomes)
* [License](#-license)
* [Author](#-author)

---

# 📖 Overview

**Enterprise Asset Management System (EAMS)** is a SAP-based application developed using the **ABAP RESTful Application Programming Model (RAP)**.

The objective of EAMS is to provide a centralized system for managing the lifecycle of organizational assets and the maintenance activities associated with those assets.

The application covers important master and transactional areas including:

* Asset Master
* Plant Master
* Plant Location
* Vendor Master
* Maintenance Service
* Repair Management
* Asset Status Management
* Warranty Management
* Validation and business-rule enforcement
* Value help and dependent value selection
* RAP-based transactional processing

The project demonstrates how a real-world business process can be modeled using modern SAP ABAP development techniques.

---

# 🎯 Business Problem

Organizations often manage physical assets using disconnected systems, spreadsheets, emails, and manual processes.

A typical asset failure process can look like:

```text
Asset Failure
     │
     ▼
User Reports Problem
     │
     ▼
Manager Reviews Request
     │
     ▼
Maintenance Team Investigates
     │
     ▼
Vendor Contacted
     │
     ▼
Repair / Maintenance Performed
     │
     ▼
Repair Status Updated
     │
     ▼
Asset Status Updated
```

This manual approach can result in:

* Duplicate data
* Delayed maintenance
* Poor asset visibility
* Difficult vendor tracking
* Inconsistent asset status
* Manual spreadsheet maintenance
* Lack of centralized information
* Increased risk of data-entry errors

EAMS addresses these problems by bringing the important asset-management information into a structured SAP RAP application.

---

# 🎯 Project Objective

The primary objectives of EAMS are:

1. Centralize organizational asset information.
2. Maintain plant and location master data.
3. Maintain vendor information.
4. Manage maintenance service requests.
5. Track repair activities.
6. Enforce business rules through RAP validations.
7. Automatically derive business information through determinations.
8. Provide user-friendly value helps.
9. Maintain consistent master data.
10. Demonstrate a complete modern SAP RAP development architecture.

---

# 🔄 Business Process

The overall business process can be represented as:

```text
                    ┌──────────────────────┐
                    │      Asset Master    │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │    Asset Registered  │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │    Asset Failure     │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │ Maintenance Service  │
                    │      Requested       │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │ Vendor / Technician  │
                    │      Assigned        │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │   Repair Activity    │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │   Repair Completed   │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │ Asset Status Updated │
                    └──────────────────────┘
```

---

# ✨ Key Features

## Asset Management

* Create assets
* Update assets
* Delete assets
* Display asset information
* Maintain asset category
* Maintain plant
* Maintain location
* Maintain department
* Maintain manufacturer
* Maintain purchase date
* Calculate warranty end date
* Maintain asset status
* Maintain asset image URL
* Asset validation
* Mandatory field validation
* Read-only field control
* Early numbering

## Plant Management

* Create plants
* Update plants
* Delete plants
* Maintain plant name
* Maintain plant type
* Automatic/controlled plant identification
* Plant-level validation

## Plant Location Management

* Create locations
* Update locations
* Delete locations
* Map locations to plants
* Support plant-dependent location selection
* Maintain plant/location combinations

## Vendor Management

* Maintain vendor master information
* Maintain vendor identification
* Maintain vendor-related data
* Support vendor information required for maintenance processes

## Service Management

* Create maintenance service records
* Update service records
* Delete service records
* Maintain service priority
* Maintain service status
* Associate service activity with asset-related processes
* Track maintenance activities

## Repair Management

* Maintain repair information
* Track repair activity
* Track repair completion
* Maintain repair status
* Support the transition from maintenance request to completed repair

---

# 🧩 Functional Modules

The application is divided into several logical modules.

| Module                  | Purpose                               |
| ----------------------- | ------------------------------------- |
| Asset Management        | Maintain organization assets          |
| Plant Management        | Maintain organizational plants        |
| Plant Location          | Maintain plant-specific locations     |
| Vendor Management       | Maintain external maintenance vendors |
| Service Management      | Manage maintenance/service activities |
| Repair Management       | Track repair activities               |
| Validation Framework    | Enforce business rules                |
| Determination Framework | Automatically derive data             |
| Value Help              | Provide controlled field selection    |
| CDS Layer               | Provide reusable data models          |
| RAP Behavior            | Handle transactional operations       |

---

# 1. 🏭 Asset Management

The Asset Management module is the central component of EAMS.

The asset master stores information required to identify and manage physical organizational assets.

### Typical Asset Information

```text
Asset ID
Asset Name
Asset Category
Plant
Department
Location
Manufacturer
Purchase Date
Warranty End Date
Asset Status
Asset Image URL
Created At
Created By
Last Changed At
```

The corresponding database object is:

```text
ZEAMS_ASSET
```

The RAP business object is:

```text
ZI_EAMS_ASSET
```

and the consumption layer includes:

```text
ZC_EAMS_ASSET
```

---

## Asset CRUD Operations

The asset business object supports:

```text
CREATE
UPDATE
DELETE
READ
```

The behavior definition also controls which fields can be changed by the user.

For example:

* Asset ID is read-only.
* Warranty End is derived.
* Asset Category is mandatory.
* Plant is mandatory.
* Location is mandatory.
* Purchase Date is mandatory.
* Asset Status is mandatory.

---

# 2. 🏢 Plant Management

Plants represent organizational or physical operating locations.

Database table:

```text
ZEAMS_PLANT
```

Interface CDS:

```text
ZI_PLANT
```

Consumption CDS:

```text
ZC_PLANT
```

### Plant Information

The plant master contains information such as:

```text
Plant
Plant Name
Plant Type
```

The RAP behavior supports:

```text
CREATE
UPDATE
DELETE
```

The plant identifier is controlled as a read-only field in the behavior definition.

---

# 3. 📍 Plant Location Management

Plant Location provides the relationship between a plant and its available locations.

Database table:

```text
ZEAMS_PLANT_LOC
```

Interface CDS:

```text
ZI_PLANT_LOC
```

Consumption CDS:

```text
ZC_PLANT_LOC
```

The system can maintain combinations such as:

```text
Plant P1
 ├── Warehouse
 ├── Production
 └── Office

Plant P2
 ├── Warehouse
 └── Production

Plant P3
 └── Office
```

This enables plant-dependent location selection.

For example:

```text
Plant = P1
```

should result in locations belonging to:

```text
P1
```

rather than displaying locations belonging to every plant.

---

# 4. 🧑‍🔧 Vendor Management

Vendor Management stores information about external organizations or service providers responsible for maintenance and repair activities.

Database table:

```text
ZEAMS_VENDOR
```

CDS layers:

```text
ZI_VENDOR
ZC_VENDOR
```

The vendor RAP implementation provides the transactional behavior required to maintain vendor information.

Vendors can participate in the maintenance lifecycle when external repair or maintenance support is required.

---

# 5. 🛠️ Service Management

Service Management handles maintenance/service activities associated with assets.

Database table:

```text
ZEAMS_SERVICE
```

CDS layers:

```text
ZI_SERVICE
ZC_SERVICE
```

The service business object provides transactional processing for service records.

Typical service information includes concepts such as:

```text
Service ID
Asset
Vendor
Priority
Service Status
Activity Information
```

Service management forms the bridge between an asset problem and the corresponding maintenance activity.

---

# 6. 🔧 Repair Management

Repair Management tracks the repair activity associated with an asset.

Database table:

```text
ZEAMS_REPAIR
```

CDS layers:

```text
ZI_REPAIR
ZC_REPAIR
```

Repair processing allows the organization to track whether an asset has been repaired and whether the repair activity has been completed.

Typical lifecycle:

```text
Repair Requested
      ↓
Repair In Progress
      ↓
Repair Completed
```

---

# 🏗️ RAP Architecture

The application follows the SAP RAP layered architecture.

```text
┌────────────────────────────────────────────┐
│              UI / Fiori Elements          │
└──────────────────────┬─────────────────────┘
                       │
                       ▼
┌────────────────────────────────────────────┐
│           Consumption CDS (ZC_*)           │
└──────────────────────┬─────────────────────┘
                       │
                       ▼
┌────────────────────────────────────────────┐
│             Interface CDS (ZI_*)           │
└──────────────────────┬─────────────────────┘
                       │
                       ▼
┌────────────────────────────────────────────┐
│              RAP Behavior Layer            │
│                                             │
│ CRUD | Validations | Determinations        │
│ Actions | Side Effects | Authorization     │
└──────────────────────┬─────────────────────┘
                       │
                       ▼
┌────────────────────────────────────────────┐
│             Database Tables                │
│                                             │
│ ZEAMS_ASSET                               │
│ ZEAMS_PLANT                               │
│ ZEAMS_PLANT_LOC                           │
│ ZEAMS_VENDOR                              │
│ ZEAMS_SERVICE                             │
│ ZEAMS_REPAIR                              │
└────────────────────────────────────────────┘
```

---

# 📐 Application Architecture

The project follows a layered design:

```text
                    Fiori / UI
                        │
                        ▼
              Consumption View
                     ZC_*
                        │
                        ▼
               Interface View
                     ZI_*
                        │
                        ▼
               Behavior Definition
                        │
                        ▼
             Behavior Implementation
                        │
                        ▼
                Persistent Table
                    ZEAMS_*
```

This separation provides:

* Reusability
* Maintainability
* Clear responsibility
* Separation of UI and business logic
* Centralized validations
* Transactional consistency

---

# 🗄️ Data Model

The main database objects are:

```text
ZEAMS_ASSET
ZEAMS_PLANT
ZEAMS_PLANT_LOC
ZEAMS_VENDOR
ZEAMS_SERVICE
ZEAMS_REPAIR
```

A simplified conceptual relationship is:

```text
                    ┌─────────────┐
                    │    PLANT    │
                    └──────┬──────┘
                           │
                           │
                    ┌──────▼──────┐
                    │   PLANT     │
                    │  LOCATION   │
                    └──────┬──────┘
                           │
                           │
              ┌────────────▼────────────┐
              │          ASSET          │
              └────────────┬────────────┘
                           │
                 ┌─────────┴─────────┐
                 │                   │
                 ▼                   ▼
          ┌─────────────┐     ┌─────────────┐
          │   SERVICE   │     │    REPAIR   │
          └──────┬──────┘     └──────┬──────┘
                 │                   │
                 └─────────┬─────────┘
                           ▼
                    ┌─────────────┐
                    │   VENDOR    │
                    └─────────────┘
```

---

# 🧱 CDS View Architecture

The project uses the standard RAP CDS separation between interface and consumption views.

## Interface Layer

Examples:

```text
ZI_EAMS_ASSET
ZI_PLANT
ZI_PLANT_LOC
ZI_SERVICE
ZI_REPAIR
ZI_VENDOR
```

The interface layer represents the reusable business object data model.

## Consumption Layer

Examples:

```text
ZC_EAMS_ASSET
ZC_PLANT
ZC_PLANT_LOC
ZC_SERVICE
ZC_REPAIR
ZC_VENDOR
```

The consumption layer exposes the business object for consumption by the UI/service layer.

---

# ⚙️ Behavior Definitions

Behavior definitions define how the RAP business objects can be manipulated.

The Asset behavior includes:

```text
CREATE
UPDATE
DELETE
```

along with:

```text
Early Numbering
Read-only Fields
Mandatory Fields
Validations
Determinations
Side Effects
ETag
Database Mapping
```

The asset behavior uses:

```text
ZI_EAMS_ASSET
```

with persistent table:

```text
ZEAMS_ASSET
```

and implementation class:

```text
ZBP_I_EAMS_ASSET
```

The implementation uses the RAP managed scenario.

---

# ✅ Validations

Business validations are implemented at the RAP behavior level.

The Asset business object contains validations for:

### Asset Status

```text
ValidateAssetStatus
```

Ensures that the entered asset status follows the defined business rules.

### Asset Category

```text
ValidateAssetCategory
```

Validates the selected asset category.

### Dates

```text
ValidateDates
```

Validates date-related business rules.

### Plant

```text
ValidatePlant
```

Ensures that the selected plant is valid.

### Location

```text
ValidateLocation
```

Ensures that the selected location is valid.

These validations are executed during the appropriate RAP save processing.

---

# 🔄 Determinations

The project uses RAP determinations to automatically derive data.

## Warranty End Date Determination

The asset behavior contains:

```text
SetWarrentyEndDate
```

This determination is triggered when an asset is created or when the purchase date is modified.

Conceptually:

```text
Purchase Date
      │
      ▼
Warranty Calculation
      │
      ▼
Warranty End Date
```

This prevents the user from having to manually calculate and enter the warranty end date.

---

# ⚡ Side Effects

The Asset business object defines a side effect between:

```text
PurchaseDate
```

and:

```text
WarrentyEnd
```

Conceptually:

```text
Purchase Date Changed
          │
          ▼
Warranty End Date Recalculated
          │
          ▼
UI Refreshes Warranty End
```

This ensures that the calculated value is reflected correctly in the UI after the source field changes.

---

# 🔢 Early Numbering

The Asset business object uses RAP early numbering.

The Asset ID is controlled by the business logic and is exposed as a read-only field.

This helps prevent users from manually changing the identifier after it has been assigned.

---

# 🔐 Authorization and Locking

The RAP behavior definitions include authorization and locking concepts.

For example, the Asset business object uses:

```text
lock master
authorization master ( instance )
etag master LocalLastChangedAt
```

These mechanisms support:

* Transaction consistency
* Concurrent access control
* Optimistic locking
* Instance-level authorization
* Prevention of conflicting updates

---

# 🔍 Value Help

The application uses controlled selection/value-help concepts for master data.

Important examples include:

```text
Asset Category
Plant
Location
Department
Vendor
Service Priority
Asset Status
```

Plant and location are particularly important because location selection is dependent on the selected plant.

Conceptually:

```text
Select Plant
     │
     ▼
Read valid plant locations
     │
     ▼
Display only relevant locations
```

This improves data quality and prevents invalid plant/location combinations.

---

# 📚 DDIC Objects

The repository contains several Data Dictionary objects.

Examples include:

### Domains

```text
ZDM_ASSET_ID
ZDM_ASSET_CATEGORY
ZDM_ASSET_DEPARTMENT
ZDM_ASSET_STATUS
ZDM_ISACTIVE
ZDM_REPAIR_DONE
ZDM_SERVICE_ID
ZDM_SERVICE_PRIORITY
ZDM_VENDORID
ZDM_ACTIVITY_NO
```

### Data Elements

```text
ZDE_ASSETID
ZDE_ASSET_CATEGORY
ZDE_ASSET_DEPARTMENT
ZDE_ASSET_STATUS
ZDE_ISACTIVE
ZDE_REPAIR_DONE
ZDE_SERVICEID
ZDE_SERVICE_PRIORITY
ZDE_VENDORID
ZDE_ACTIVITY_NO
```

The use of DDIC objects provides centralized type definitions and promotes consistency throughout the application.

---

# 📁 Repository Structure

The project is organized using an ABAPGit-compatible structure.

```text
EAMS-PROJECT/
│
├── .abapgit.xml
├── LICENSE
├── README.md
│
└── src/
    │
    ├── package.devc.xml
    │
    ├── Database Tables
    │   ├── zeams_asset.tabl.xml
    │   ├── zeams_plant.tabl.xml
    │   ├── zeams_plant_loc.tabl.xml
    │   ├── zeams_vendor.tabl.xml
    │   ├── zeams_service.tabl.xml
    │   └── zeams_repair.tabl.xml
    │
    ├── Asset
    │   ├── zi_eams_asset.ddls.asddls
    │   ├── zi_eams_asset.bdef.asbdef
    │   ├── zc_eams_asset.ddls.asddls
    │   ├── zc_eams_asset.bdef.asbdef
    │   ├── zbp_i_eams_asset.clas.abap
    │   └── zbp_i_eams_asset.clas.locals_imp.abap
    │
    ├── Plant
    │   ├── zi_plant.ddls.asddls
    │   ├── zi_plant.bdef.asbdef
    │   ├── zc_plant.ddls.asddls
    │   └── zbp_i_plant1.clas.abap
    │
    ├── Plant Location
    │   ├── zi_plant_loc.ddls.asddls
    │   ├── zi_plant_loc.bdef.asbdef
    │   ├── zc_plant_loc.ddls.asddls
    │   └── zbp_i_plant_loc.clas.abap
    │
    ├── Vendor
    │   ├── zi_vendor.ddls.asddls
    │   ├── zi_vendor.bdef.asbdef
    │   ├── zc_vendor.ddls.asddls
    │   └── zbp_i_vendor_.clas.abap
    │
    ├── Service
    │   ├── zi_service.ddls.asddls
    │   ├── zi_service.bdef.asbdef
    │   ├── zc_service.ddls.asddls
    │   └── zbp_i_service.clas.abap
    │
    ├── Repair
    │   ├── zi_repair.ddls.asddls
    │   ├── zc_repair.ddls.asddls
    │   └── zc_repair.ddlx.asddlxs
    │
    └── DDIC
        ├── Domains
        └── Data Elements
```

The repository currently contains the source package, RAP artifacts, CDS artifacts, behavior definitions, implementation classes, tables, domains, data elements, and UI-related metadata.

---

# 🛠️ Technology Stack

| Technology              | Usage                                         |
| ----------------------- | --------------------------------------------- |
| SAP ABAP                | Application development                       |
| ABAP Cloud              | Modern ABAP development                       |
| RAP                     | Business object and transactional programming |
| CDS                     | Data modeling                                 |
| CDS View Entities       | Interface and consumption modeling            |
| Behavior Definition     | Transactional behavior                        |
| Behavior Implementation | Business logic                                |
| DDIC                    | Domains and data elements                     |
| Fiori Elements          | Potential UI consumption layer                |
| OData                   | Service exposure                              |
| ABAPGit                 | Source-code version control                   |
| GitHub                  | Repository hosting                            |

---

# 💻 Development Environment

The project is designed for development using:

* SAP Business Technology Platform
* SAP BTP ABAP Environment
* Eclipse
* ABAP Development Tools (ADT)
* ABAPGit
* GitHub

Recommended development workflow:

```text
Eclipse / ADT
      │
      ▼
SAP BTP ABAP Environment
      │
      ▼
Develop RAP Objects
      │
      ▼
Test Business Objects
      │
      ▼
ABAPGit
      │
      ▼
GitHub
```

---

# 🚀 Installation and Setup

## Prerequisites

Before working with this project, you should have:

* SAP BTP account
* SAP BTP ABAP Environment system
* Eclipse IDE
* ABAP Development Tools
* ABAPGit
* Appropriate development authorization
* GitHub account

---

## Clone the Repository

```bash
git clone https://github.com/Aarchikunchal/EAMS-PROJECT.git
```

Then open the repository using your preferred Git workflow or import the objects into an ABAP environment using ABAPGit.

---

# 📥 Import Using ABAPGit

1. Open Eclipse.
2. Connect to the SAP BTP ABAP system.
3. Open the ABAPGit repository/client.
4. Create or select the target ABAP package.
5. Use the repository URL:

```text
https://github.com/Aarchikunchal/EAMS-PROJECT
```

6. Pull/import the repository.
7. Activate the imported objects.
8. Check dependencies.
9. Test the CDS views.
10. Test the RAP behavior.
11. Create the required service exposure/binding for UI consumption.

---

# 🧪 Testing

The project can be tested progressively.

## Level 1 — Database

Verify:

```text
ZEAMS_ASSET
ZEAMS_PLANT
ZEAMS_PLANT_LOC
ZEAMS_VENDOR
ZEAMS_SERVICE
ZEAMS_REPAIR
```

## Level 2 — CDS

Test:

```text
ZI_EAMS_ASSET
ZI_PLANT
ZI_PLANT_LOC
ZI_VENDOR
ZI_SERVICE
ZI_REPAIR
```

Then test consumption views:

```text
ZC_EAMS_ASSET
ZC_PLANT
ZC_PLANT_LOC
ZC_VENDOR
ZC_SERVICE
ZC_REPAIR
```

## Level 3 — Behavior

Test:

```text
CREATE
UPDATE
DELETE
VALIDATIONS
DETERMINATIONS
SIDE EFFECTS
NUMBERING
```

## Level 4 — UI

Test:

```text
Create Asset
Edit Asset
Delete Asset
Select Plant
Select Location
Validate Asset Data
Calculate Warranty
Maintain Service
Maintain Repair
```

---

# 🔄 Complete Application Flow

A typical asset lifecycle is:

```text
                 ┌───────────────┐
                 │ Create Plant  │
                 └───────┬───────┘
                         │
                         ▼
              ┌─────────────────────┐
              │ Create Plant        │
              │ Location            │
              └──────────┬──────────┘
                         │
                         ▼
                 ┌──────────────┐
                 │ Create Asset │
                 └──────┬───────┘
                        │
                        ▼
              ┌────────────────────┐
              │ Select Asset       │
              │ Category           │
              └─────────┬──────────┘
                        │
                        ▼
                 ┌──────────────┐
                 │ Select Plant │
                 └──────┬───────┘
                        │
                        ▼
             ┌─────────────────────┐
             │ Select Valid        │
             │ Plant Location      │
             └──────────┬──────────┘
                        │
                        ▼
              ┌────────────────────┐
              │ Enter Purchase     │
              │ Date               │
              └─────────┬──────────┘
                        │
                        ▼
             ┌──────────────────────┐
             │ Warranty End Date    │
             │ Automatically Derived│
             └──────────┬───────────┘
                        │
                        ▼
                 ┌─────────────┐
                 │ Save Asset  │
                 └──────┬──────┘
                        │
                        ▼
              ┌────────────────────┐
              │ Asset Failure /   │
              │ Maintenance Need  │
              └─────────┬──────────┘
                        │
                        ▼
              ┌────────────────────┐
              │ Create Service     │
              └─────────┬──────────┘
                        │
                        ▼
              ┌────────────────────┐
              │ Assign Vendor      │
              └─────────┬──────────┘
                        │
                        ▼
              ┌────────────────────┐
              │ Create Repair      │
              └─────────┬──────────┘
                        │
                        ▼
              ┌────────────────────┐
              │ Complete Repair    │
              └─────────┬──────────┘
                        │
                        ▼
              ┌────────────────────┐
              │ Update Asset Status│
              └────────────────────┘
```

---

# 🧠 RAP Concepts Demonstrated

This project demonstrates several important SAP RAP concepts.

### Data Modeling

* Database tables
* CDS view entities
* Interface views
* Consumption views

### Transactional Processing

* Managed RAP
* Behavior definitions
* Behavior implementation
* CRUD operations

### Business Logic

* Validations
* Determinations
* Side effects
* Numbering
* Field control

### Data Quality

* Mandatory fields
* Read-only fields
* Value helps
* Plant/location dependency
* Business-rule validation

### Concurrency

* ETag
* Local last-changed timestamp
* RAP locking

### Development Practices

* Modular design
* DDIC reuse
* ABAPGit
* GitHub source control

---

# 📊 Business Benefits

EAMS provides the foundation for:

### Centralized Asset Information

All important asset information can be maintained in one application.

### Better Data Quality

Mandatory fields, validations, value helps, and controlled master data reduce invalid entries.

### Improved Maintenance Tracking

Service and repair information can be maintained alongside asset information.

### Reduced Manual Work

Determinations such as warranty-date calculation reduce repetitive manual calculations.

### Better Organizational Visibility

Plant and location information provides structured visibility of where assets are located.

### Extensibility

The RAP architecture allows additional business logic, actions, associations, authorizations, and UI capabilities to be added later.

---

# 🔮 Future Enhancements

The project can be extended with additional enterprise capabilities.

## Maintenance Request Workflow

```text
Reported
   ↓
Under Review
   ↓
Approved
   ↓
Assigned
   ↓
In Progress
   ↓
Completed
   ↓
Closed
```

## Email Notifications

Automatic notifications for:

* Asset failures
* Service creation
* Manager approval
* Vendor assignment
* Repair completion
* Warranty expiration

## Approval Workflow

Introduce manager approval before maintenance work begins.

## Vendor Assignment

Automatically suggest vendors based on:

* Asset category
* Plant
* Location
* Service type
* Vendor capability

## Preventive Maintenance

Add:

* Maintenance schedules
* Maintenance plans
* Maintenance intervals
* Upcoming maintenance notifications

## Dashboard

Possible KPIs:

```text
Total Assets
Active Assets
Assets Under Repair
Assets Under Warranty
Expired Warranty Assets
Open Service Requests
Open Repairs
Completed Repairs
Critical Assets
```

## Asset History

Maintain historical information such as:

```text
Asset Created
Asset Modified
Service Requested
Vendor Assigned
Repair Started
Repair Completed
Asset Status Changed
```

## Authorization

Introduce role-based access such as:

```text
Administrator
Asset Manager
Maintenance Manager
Maintenance Technician
Vendor
Business User
```

---

# 🎓 Learning Outcomes

This project is also designed as a practical SAP ABAP RAP learning project.

It demonstrates how to build a real-world application using modern SAP development techniques.

Through this project, developers can learn:

* SAP ABAP Cloud
* Eclipse ADT
* ABAP RAP
* CDS View Entities
* RAP Behavior Definitions
* Behavior Implementation Classes
* Managed RAP
* CRUD operations
* RAP validations
* RAP determinations
* Side effects
* Early numbering
* ETags
* Locking
* Authorization concepts
* DDIC domains
* DDIC data elements
* Database table design
* Value help
* Fiori Elements concepts
* OData service exposure
* ABAPGit
* GitHub-based source control

---

# 🏆 Project Highlights

The project demonstrates a complete enterprise-oriented SAP development approach rather than a simple CRUD application.

Important implementation highlights include:

```text
✔ SAP BTP ABAP Environment
✔ Modern ABAP
✔ RAP Business Objects
✔ CDS Interface Views
✔ CDS Consumption Views
✔ Managed RAP
✔ CRUD Operations
✔ Validations
✔ Determinations
✔ Side Effects
✔ Early Numbering
✔ ETag / Concurrency Handling
✔ Authorization Concepts
✔ Mandatory Fields
✔ Read-only Fields
✔ Plant Master
✔ Plant Location Master
✔ Asset Master
✔ Vendor Master
✔ Service Management
✔ Repair Management
✔ DDIC Domains
✔ DDIC Data Elements
✔ ABAPGit
✔ GitHub
```

The repository currently contains the corresponding RAP, CDS, DDIC, table, and behavior artifacts for these areas.

---

# 📌 Current Project Scope

The current repository is focused on the core EAMS foundation:

```text
                    EAMS
                     │
        ┌────────────┼────────────┐
        │            │            │
        ▼            ▼            ▼
      Master      Maintenance   Repair
      Data        Services      Process
        │            │            │
        ▼            ▼            ▼
     ┌──────┐     ┌────────┐   ┌────────┐
     │Asset │     │Service │   │ Repair │
     └──────┘     └────────┘   └────────┘
        │            │            │
        ├──────┐     │            │
        │      │     │            │
        ▼      ▼     ▼            ▼
      Plant  Location Vendor   Completion
```

---

# 📂 Main Repository

The complete project source code is available here:

**EAMS-PROJECT**

https://github.com/Aarchikunchal/EAMS-PROJECT

---

# 📄 License

This project is licensed under the **MIT License**.

See the [LICENSE](LICENSE) file for details.

---

# 👩‍💻 Author

**Aarchi Kunchal**

SAP ABAP / RAP Developer

GitHub:

https://github.com/Aarchikunchal

---

# ⭐ Support

If you find this project useful for learning SAP ABAP RAP or Enterprise Asset Management concepts, consider giving the repository a ⭐ on GitHub.

---

## 🚀 Final Note

EAMS is designed as a practical example of how a real-world Enterprise Asset Management process can be modeled using SAP's modern **ABAP RESTful Application Programming Model**.

The project combines:

**Business Process + Database Design + CDS Modeling + RAP Behavior + Business Logic + Validation + Determination + Master Data + Maintenance Processing**

to provide a foundation that can be further evolved into a complete enterprise-grade SAP Fiori application.

