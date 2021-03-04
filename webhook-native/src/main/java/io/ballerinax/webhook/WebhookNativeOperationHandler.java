package io.ballerinax.webhook;

import io.ballerina.runtime.api.Environment;
import io.ballerina.runtime.api.Module;
import io.ballerina.runtime.api.async.StrandMetadata;
import io.ballerina.runtime.api.creators.ValueCreator;
import io.ballerina.runtime.api.types.MethodType;
import io.ballerina.runtime.api.utils.StringUtils;
import io.ballerina.runtime.api.values.BArray;
import io.ballerina.runtime.api.values.BError;
import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BObject;
import io.ballerina.runtime.api.values.BString;

import java.util.ArrayList;
import java.util.concurrent.CountDownLatch;

public class WebhookNativeOperationHandler {
    public static void printMessage() {
        System.out.println("This is a message from [Ballerina] to [Java]");
    }
    // public static Object callOnStartupMethod(Environment env, BObject bWebhookService, BMap<BString, Object> message) {
    //     return invokeRemoteFunction(env, bWebhookService, message, "callOnStartupMethod", "onStartup");
    // }

    // public static Object callOnEventMethod(Environment env, BObject bWebhookService, BMap<BString, Object> message) {
    //     return invokeRemoteFunction(env, bWebhookService, message, "callOnEventMethod", "onEvent");
    // }

    private static Object invokeRemoteFunction(Environment env, BObject bWebhookService, BMap<BString, Object> message,
                                               String parentFunctionName, String remoteFunctionName) {
        Module module = ModuleUtils.getModule();
        StrandMetadata metadata = new StrandMetadata(module.getOrg(), module.getName(), module.getVersion(), 
                                                    parentFunctionName);
        CountDownLatch latch = new CountDownLatch(1);
        CallableUnitCallback callback = new CallableUnitCallback(latch);

        Object[] args = new Object[]{message, true};
        env.getRuntime().invokeMethodAsync(bWebhookService, remoteFunctionName, null, metadata, callback, args);

        try {
            latch.await();
        } catch (InterruptedException e) {
            // Ignore
        }
        return callback.getResult();
    }
}