# CrimeLocator

## [GitHub Link(Main Branch)](https://github.com/rmit-iPSE-s2-2023/a1-s3842316-s3825891) 



	Group No: - CrimeLocator_a1
	ID: s3825891 - Name: Jainam Doshi
	ID: S3842316 - Name: Sahibjeet Singh

## Table of Contents

-   About
-   Features
-   Installation
-   App Structure
-   Requirements
-   Usage

## About

This project aims to empower users with real-time information about crime activities in their respective neighbourhoods. Built with a vision to make communities safer and more informed.

## Features

-   View crime reports in your location
-   View recent activities
-   Search suburbs
-   View locations on map
-   Add suburbs to your watch zone
-   View recent reports
-   User settings

## Installation

To install the app, you'll need to:

1.  Clone the repository
2.  Open the project in Xcode
3.  Run the app on an iOS simulator or a physical device

## App Structure

Here's a basic overview of the directory structure:

-   **crimeLocator/**
    
    -   `CrimeLocatorApp.swift`: App entry point
    -   `ContentView.swift`: Main app view
-   **Model/**
    
    -   `User.swift`: User model
    -   `DataLoader.swift`: Utility for loading data
    -   `Report.swift`: Crime report model
    -   `Suburb.swift`: Suburb model
    -   `Location.swift`: Location model
    -   `Utils.swift`: Helper functions
-   **Views/**
    
    -   `HomeView.swift`: View for recent reports and other features
    -   `FavoriteView.swift`: View for Watch Zone
    -   `RecentView.swift`: View for recent suburbs
    -   `SettingView.swift`: View for settings
    -   `CommonViews.swift`: Reusable components
    -   `HomeListRowView.swift`: Detailed view for HomeView List Items
    -   `SearchView.swift`: View for searching suburbs
    -   `SuburbView.swift`: Detailed view for a suburb
-   **Resources**
    
    -   `UserData.json`: Mock user data
    -   `ReportData.json`: Mock report data

## Requirements

-   iOS 15.0 
-   Xcode 13
-   SwiftUI

## Usage

Open the project in Xcode, build and run



