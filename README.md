# Dockerfile Setup for Java, Apache, Python Installation with Automation

This project provides a Dockerfile that creates a Linux-based Docker image with the following software installed:

Latest Ubuntu-based Linux image
Apache HTTP Server
OpenJDK (Java)
Python 3.x
A sample Index.html deployed to the /www folder
A sample WAR (Java) application deployed to Apache Tomcat

Additionally, the process of building the Docker image, saving it as a .tar file, and uploading it to Google Cloud Storage is automated using a Python script.

# Prerequisites:

Before proceeding, ensure you have the following installed on your machine:

Docker: To build and run Docker images.
Google Cloud SDK (gsutil): To upload the Docker image to Google Cloud Storage.
Python 3.x: Required to run the automation script.

Additionally, ensure you have access to a Google Cloud Storage bucket where the Docker image will be stored.
