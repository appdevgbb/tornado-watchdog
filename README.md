# Tornado Watchdog Severe Weather Alerting System

**This project introduces a sample scenario based on the [Azure Iot Edge Watchdog Sample](https://github.com/Azure-Samples/iot-edge-watchdog) from [these open-source contributors](https://github.com/Azure-Samples/iot-edge-watchdog/graphs/contributors).**

In this example, the Iot Edge device(s) are simulated sensors that can detect cyclone activity based on environmental factors. The devices send "watch" or "warning" messages in the case of severe weather conditions which are routed through a notification system in Microsoft Azure. These events may also trigger a workflow in a companion [Power Platform](https://powerplatform.microsoft.com/en-us/) system that pushes notifications to end users via a [Power Virtual Agent ](https://powervirtualagents.microsoft.com) bot installed in Microsoft Teams.

In addition to receiving notifications via the bot, they can also interact with the bot to ask common questions about severe weather and cyclone activity. This Q&A capability is provided by [Question Answering](https://azure.microsoft.com/en-us/products/cognitive-services/question-answering/#overview) in Microsoft Azure.

This project demonstrates an event-driven architecture beginning with Azure IoT edge devices connected to Azure IoT Hub that trigger Azure Functions and end in a notification system in Power Platform and Microsoft Teams.

![Event-driven architecture diagram](https://user-images.githubusercontent.com/1610195/193479464-b5b8361a-f154-4787-9bae-abaf28b5770d.png)

## Contents

**IoT Edge Demo adapted from [IoT Edge Watchdog](https://github.com/Azure-Samples/iot-edge-watchdog)**

- *edge/SimulatedEdgeDevice/modules*: Deploy this module to the Azure IoT Edge devices and it will
send messages to the corresponding IoT Hub.

- *cloud/IoTHubListener*: This is the Azure Function trigged by the Event Hub compatible endpoint for IoT Hub. Deploy this function to Azure and it will pick up the messages from the Azure IoT Edge Module as they enter the IoT Hub and then log and process them.

- *shared/HeartbeatMessage*: Shared object model (protobuf) between cloud and edge, to ease serialization across applications. This project can be modified to produce a Nuget package that can be consumed as a package reference, rather than as a linked/dependent project.

**Power Platform Archive** 

- *solutions/*: This folder contains the solution files for the Power Platform piece of this project:
    - Power Apps Canvas App for displaying historical events
    - Power Automate Flow for capturing events from the IoT architecture in Azure
    - Virtual Agent for connecting to the tornado knowledge base and accepting event notifications

## Get Started - Prereqs

1. Language SDKs

- [.NET Core SDK (6.0)](https://www.microsoft.com/net/download)
- [Node.js (LTS)](https://nodejs.org) - required for local development of the Azure
Functions Core Tools.

2. Docker

- [Docker Community Edition](https://docs.docker.com/install/)

3. Azure Resources

To run this project, you will need the following Azure resources:
- [Azure IoT Hub](https://azure.microsoft.com/en-us/services/iot-hub/)
- [Azure Event Hubs](https://azure.microsoft.com/en-us/services/event-hubs/)
- [Azure IoT Edge](https://azure.microsoft.com/en-us/services/iot-edge/)
- [Azure Container Registry](https://azure.microsoft.com/en-us/services/container-registry/) or other container registry
- [Question Answering](https://azure.microsoft.com/en-us/products/cognitive-services/question-answering/#overview)
    - Note: You must create your first Face, Text Analytics, or Computer Vision resources from the Azure portal to review and acknowledge the terms and conditions. In Azure Portal, the checkbox to accept terms and conditions is only displayed when a US region is selected. More information on Prerequisites.

4. Power Platform Resources

To run the Power Platform components of this project, you will also need a Power Platform tenant with access to premium connectors. You can
sign up for a 30-day subscription [here](https://go.microsoft.com/fwlink/?LinkId=2180357&clcid=0x409).

You will also need access to a Teams environment in the same Microsoft tenant for interacting with the bot and receiving event notifications.

4. Azure Functions Core Tools

Install [Azure Functions Core Tools](https://github.com/Microsoft/vscode-azurefunctions/blob/master/README.md)

``` bash
    npm install -g azure-functions-core-tools
```

**[The following instructions adapted from base iot-edge-watchdog repository](https://github.com/Azure-Samples/iot-edge-watchdog#azure-iot-edge-module-simulated-edge-device)**

### Azure IoT Edge Module 

In the provided `env` file (remove the `.temp` extension) there are many configurable variables.

**If you are using `localhost` are your registry, then you can leave username and password blank**

### Iot Hub Listener

This is an Azure Function that provides the processing of the IoT messages and pushes events to the destination Event Hub

### Environment settings and use/development

There four settings to configure for the IoT HuB listener in the `local.settings.json.temp` file:

```
    "IoTHubAckConnectionString":"",
    "EventHubEgressConnectionString":"",
    "EventHubIngestConnectionString":"",
    "AzureWebJobsStorage": "",
    "FUNCTIONS_WORKER_RUNTIME": "dotnet"
```

- **IoTHubAckConnectionString** - connection string for the Azure IoT Hub
- **EventHubEgressConnectionString** - Azure Event Hubs compatible endpoint for IoT Hub
- **EventHubIngestConnectionString** - Azure Event Hubs where the processed data is sent (serves as trigger fro the Power Automate workflow in Power Platform)
- **AzureWebJobsStorage** - backing storage for Azure Functions
