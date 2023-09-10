// imports
bring cloud;
bring ex;
// resources
let wingpressoApi = new cloud.Api();
let counter = new cloud.Counter(initial: 0);
let orderEvents = new cloud.Topic();
let orders = new ex.Table(
  name: "orders",
  primaryKey: "id",
  columns: {
    "productId" => ex.ColumnType.STRING,
    "customerId" => ex.ColumnType.STRING,
    "status" => ex.ColumnType.STRING 
  }
);
// data structures
struct Order {
  productId: str;
  customerId: str;
  status: str?;
}
// utils
let toOrderFromJson = inflight (jsonData: Json): Order => {
  return Order {
    productId: str.fromJson(jsonData.tryGet("productId")),
    customerId: str.fromJson(jsonData.tryGet("customerId")),
    status: str.fromJson(jsonData.tryGet("status")) // find a way to set default status
  };
};
// usage
// api gateway routes
wingpressoApi.post("/orders", inflight (request: cloud.ApiRequest): cloud.ApiResponse => { 
  if let body = request.body {
    let jsonData = Json.parse(body);
    let id = "${counter.inc()}";
    let orderData = toOrderFromJson(jsonData);
    try {
      orders.insert(id, orderData);  
      orderEvents.publish("order id: ${id} customer ${orderData.customerId} purchased ${orderData.customerId}");
    } catch e {
      throw("db insert exception");
      log("${e} db insert exception");
    } finally {
      log("done");
      return cloud.ApiResponse {
        status: 201,
        body: "${id}, customer ${orderData.customerId} purchased ${orderData.customerId}"
      };
    } 
   }
});
wingpressoApi.get("/orders/{id}", inflight (request: cloud.ApiRequest): cloud.ApiResponse => {
  let requestData = orders.get(request.vars.get("id"));
  let orderData = toOrderFromJson(requestData);
  return cloud.ApiResponse {
    status: 200,
    body: Json.stringify("customer ${orderData.customerId} ordered ${orderData.productId}")
  };
});
wingpressoApi.put("/orders/{id}", inflight (request: cloud.ApiRequest): cloud.ApiResponse => { 
  if let body = request.body {
    let jsonBody = Json.parse(body); // { status: "complete" }
    let jsonStatus = jsonBody.tryGet("status"); // "complete"
    let orderTableData = orders.get(request.vars.get("id")); // {id: 0, productId: "coffee", customerId: "john", status: nil}
    let orderDataJson = Json {
      productId: orderTableData.get("productId"),
      customerId: orderTableData.get("customerId"),
      status: jsonStatus
    };  
    let orderDataStruct = toOrderFromJson(orderDataJson); 
    try {
      orders.update(request.vars.get("id"), orderDataJson);
      orderEvents.publish("order id: ${request.vars.get("id")} customer ${orderDataStruct.customerId} order ${orderDataStruct.productId} status updated to ${orderDataStruct.status}");
    } catch e {
      throw("db insert exception");
      log("${e} db insert exception");
    } finally {
      log("done");
      return cloud.ApiResponse {
        status: 201,
        body: "order id: ${request.vars.get("id")} customer ${orderDataStruct.customerId} order ${orderDataStruct.productId} status updated to ${orderDataStruct.status}"
      };
    } 
   }
});
// sns topic subscriptions
orderEvents.onMessage(inflight (msg: str) => {
   log("${msg}!");
});

// // test data
// {
//   "productId": "test 1",
//   "customerId" : "customer 1"
// }
// {
//   "productId": "test 1",
//   "customerId" : "customer 1",
// "status": "complete"
// }