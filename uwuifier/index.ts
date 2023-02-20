import { AzureFunction, Context, HttpRequest } from "@azure/functions"

import Uwuifier, {} from "uwuifier"

const httpTrigger: AzureFunction = async function (context: Context, req: HttpRequest): Promise<void> {
    context.log('HTTP trigger function processed a request.');
    const text = (req.query.text || (req.body && req.body.text));

    const uwuifier = new Uwuifier();
    const responseMessage = uwuifier.uwuifySentence(text)

    context.res = {
        // status: 200, /* Defaults to 200 */
        body: responseMessage
    };

};

export default httpTrigger;