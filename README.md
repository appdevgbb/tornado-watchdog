# Tornado Watchdog Severe Weather Alerting System

This project introduces a sample scenario based on the [Azure Iot Edge Watchdog Sample](https://github.com/Azure-Samples/iot-edge-watchdog) from [these open-source contributors](https://github.com/Azure-Samples/iot-edge-watchdog/graphs/contributors). In this example, the Iot Edge device(s) are simulated sensors that can detect cyclone activity based on environmental factors. The devices send "watch" or "warning" messages in the case of severe weather conditions which are routed through a notification system in Microsoft Azure. These events may also trigger a workflow in a companion Power Platform system that pushes notifications to end users via a bot installed in Microsoft Teams.

This project demonstrates an event-driven architecture beginning with Azure IoT edge devices connected to Azure IoT Hub that trigger Azure Functions and end in a notification system in Power Platform/Microsoft Teams.

![Event-driven architecture diagram](https://user-images.githubusercontent.com/1610195/164374932-fd535cda-6c48-404c-80f9-5f05c32bf82d.png)

## Contents

This project has four parts:

- **edge/SimulatedEdgeDevice/modules**: Deploy this module to the Azure IoT Edge devices and it will
send messages to the corresponding IoT Hub.

- **cloud/IoTHubListener**: This is the Azure Function trigged by the Event Hub compatible endpoint for IoT Hub. Deploy this function to Azure and it will pick up the messages from the Azure IoT Edge Module as they enter the IoT Hub and then log and process them.

- **shared/HeartbeatMessage**: Shared object model (protobuf) between cloud and edge, to ease serialization across applications. This project can be modified to produce a Nuget package that can be consumed as a package reference, rather than as a linked/dependent project.

- **solutions/**: This folder contains the solution files for the Power Platform piece of this project:
    - Power Apps Canvas App for displaying historical events
    - Power Automate Flow for capturing events from the IoT architecture in Azure
    - Virtual Agent for connecting to the tornado knowledge base and accepting event notifications

## Get Started

1. Language SDKs

- [.NET Core SDK (6.0)](https://www.microsoft.com/net/download)
- [Node.js (LTS)](https://nodejs.org) - required for local development of the Azure
Functions Core Tools.

2. Docker

[Docker Community Edition](https://docs.docker.com/install/) - required for Azure IoT Edge
module development, deployment and debugging. Docker CE is free, but may require registration with Docker account to download.

3. Azure Resources

To run this project, you will need the following Azure resources:
- [Azure IoT Hub](https://azure.microsoft.com/en-us/services/iot-hub/)
- [Azure Event Hubs](https://azure.microsoft.com/en-us/services/event-hubs/)
- [Azure IoT Edge](https://azure.microsoft.com/en-us/services/iot-edge/)
- [Azure Container Registry](https://azure.microsoft.com/en-us/services/container-registry/) or other container registry
- [QnA Maker](https://www.qnamaker.ai/)

4. Power Platform Resources

To run the Power Platform components of this project, you will also need a Power Platform tenant with access to premium connectors. You can
sign up for a 30-day subscription [here](https://go.microsoft.com/fwlink/?LinkId=2180357&clcid=0x409).

You will also need access to a Teams environment in the same Microsoft tenant for interacting with the bot and receiving event notifications.

4. IDE and extensions
- Visual Studio Code

    Install [Visual Studio Code](https://code.visualstudio.com/) and add the following extensions:

    - [C# extension](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp) (only
    required for C# version of sample) - provides C# syntax checking, build and debug support
    - [Azure IoT Tools](https://marketplace.visualstudio.com/items?itemName=vsciot-vscode.azure-iot-tools) - provides Azure IoT Edge development tooling
    - [Azure Functions](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions)

- Visual Studio
    - Install [Visual Studio](https://docs.microsoft.com/en-us/visualstudio/install/install-visual-studio?view=vs-2019) first and then add the following extensions:
    - [Azure IoT Edge Tools](https://marketplace.visualstudio.com/items?itemName=vsc-iot.vs16iotedgetools) - provides Azure IoT Edge development tooling for Visual Studio
    - [Azure Function](https://marketplace.visualstudio.com/items?itemName=VisualStudioWebandAzureTools.AzureFunctionsandWebJobsTools) - skip if using Visual Studio 2019

5. Azure Functions Core Tools

 [Azure Functions Core Tools](https://github.com/Microsoft/vscode-azurefunctions/blob/master/README.md) is a version of the Azure Functions runtime for local development machine. It also provides commands to create functions, connect to Azure, and deploy Azure Function projects.  After verifying Node.js (LTS) is installed and in the path, install **[azure-functions-core-tools](https://www.npmjs.com/package/azure-functions-core-tools)** with npm:

``` bash
    npm install -g azure-functions-core-tools
```

### Azure IoT Edge Module (Simulated Edge Device)

In the provided `env` file (remove the `.temp` extension) there are many configurable variables.  At a minimum, you will need to fill in the container registry settings.
If you are using `localhost` are your registry, then you can leave username and password blank.

### Iot Hub Listener

The **IoT Hub Listener** is an Azure Function that provides the intermediate logging and processing of the IoT messages. The Azure Function requires an input Event Hub, such as IoT Hub's Event Hub compatible endpoint, and an output Event Hub. The output Event Hub can be mapped to Azure Data Lake storage for persistence of messages.

### Environment settings and use/development

There are four settings to configure for the IoT HuB listener. These are in the `local.settings.json.temp` file.  After changing the settings, remove the `.temp` extension.

```
    "IoTHubAckConnectionString":"",
    "EventHubEgressConnectionString":"",
    "EventHubIngestConnectionString":"",
    "AzureWebJobsStorage": "",
    "FUNCTIONS_WORKER_RUNTIME": "dotnet"
```

First set the connection string for the Azure IoT Hub and then connection string for the Azure Event Hubs compatible endpoint. This second string is what will trigger and provide event data to the Azure Function. The Ingest Event Hub Endpoint is where the processed data gets sent and which enables the Azure Data Lake or another service
to access the processed message.  It also serves as the trigger for the Power Automate workflow in Power Platform. Finally, AzureWebJobsStorage is a required backing store for Azure Functions.  This can be a local Azure Storage Emulator with the setting `UseDevelopmentStorage=true`.

### HeartMessage

The heartbeat message is [protocol buffer](https://developers.google.com/protocol-buffers/).  Simply define it in the `.proto`
file and include the `csproj` file.  The underlying C# will be generated for you.
