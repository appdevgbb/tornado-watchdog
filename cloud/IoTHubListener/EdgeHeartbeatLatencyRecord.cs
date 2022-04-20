using System;

namespace GWManagementFunctions
{
    public class EdgeHeartbeatLatencyRecord
    {
        public string DeviceId { get; private set; }
        public string ModuleId { get; private set; }
        public Int64 MessageId { get; private set; }

        public string MessageType { get; private set;}
        public Int64 EdgeCreatedTimeTicks { get; private set; }
        public Int64 IoTHubEnqueuedTimeTicks { get; private set; }
        public Int64 AzFncInitializedTimeTicks { get; private set; }
        public Int64 EdgeToHubLatencyMs { get; private set; }
        public Int64 EdgeToAzFncLatencyMs { get; private set; }

        public string Sent { get; private set; }

        public string Effective { get; private set; }

        public string Onset { get; private set; }

        public string Expires { get; private set; }

        public string Severity { get; private set; }

        public string Ends { get; private set; }

        public string Status { get; private set; }

        public string Category { get; private set; }

        public string Certainty { get; private set; }

        public string Urgency { get; private set; }

        public string Event { get; private set; }

        public string Headline { get; private set; }

        public string Instruction { get; private set; }

        public EdgeHeartbeatLatencyRecord(
                string deviceId,
                string moduleId,
                Int64 msgId,
                string msgType,
                Int64 EdgeCreatedTime,
                Int64 IotHubEnqueueTime,
                Int64 AzFncInitializedTime,
                string sent,
                string effective,
                string onset,
                string expires,
                string severity,
                string ends,
                string status,
                string category,
                string certainty,
                string urgency,
                string eventName,
                string headline,
                string instruction)

        {
            DeviceId = deviceId;
            ModuleId = moduleId;
            MessageId = msgId;
            MessageType = msgType;
            EdgeCreatedTimeTicks = EdgeCreatedTime;
            IoTHubEnqueuedTimeTicks = IotHubEnqueueTime;
            AzFncInitializedTimeTicks = AzFncInitializedTime;
            Sent = sent;
            Effective = effective;
            Onset = onset;
            Expires = expires;
            Severity = severity;
            Ends = ends;
            Status = status;
            Category = category;
            Certainty = certainty;
            Urgency = urgency;
            Event = eventName;
            Headline = headline;
            Instruction = instruction;
            EdgeToHubLatencyMs =
                (IoTHubEnqueuedTimeTicks - EdgeCreatedTimeTicks) / TimeSpan.TicksPerMillisecond;
            EdgeToAzFncLatencyMs =
                (AzFncInitializedTimeTicks - EdgeCreatedTimeTicks) / TimeSpan.TicksPerMillisecond;
        }
    }
}
