import MQTTNIO

let client = MQTTClient(
    host: "localhost",
    port: 1883,
    identifier: "My Client",
    eventLoopGroupProvider: .createNew
)
try client.connect().always { result in 
    switch result {
    case .success:
        print("Succesfully connected")
    case .failure(let error):
        print("Error while connecting \(error)")
    }
}.wait()
