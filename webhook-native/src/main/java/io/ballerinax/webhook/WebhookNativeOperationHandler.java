package io.ballerinax.webhook;

import io.ballerina.runtime.api.Environment;
import io.ballerina.runtime.api.Future;
import io.ballerina.runtime.api.Module;
import io.ballerina.runtime.api.async.Callback;
import io.ballerina.runtime.api.async.StrandMetadata;
import io.ballerina.runtime.api.creators.ErrorCreator;
import io.ballerina.runtime.api.creators.ValueCreator;
import io.ballerina.runtime.api.types.MethodType;
import io.ballerina.runtime.api.utils.StringUtils;
import io.ballerina.runtime.api.values.BArray;
import io.ballerina.runtime.api.values.BError;
import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BObject;
import io.ballerina.runtime.api.values.BString;

import java.util.ArrayList;

import static io.ballerina.runtime.api.utils.StringUtils.fromString;

public class WebhookNativeOperationHandler {
    public static Object callOnStartupMethod(Environment env, BObject bWebhookService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bWebhookService, message, "callOnStartupMethod", "onStartup");
    }

    public static Object callOnEventMethod(Environment env, BObject bWebhookService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bWebhookService, message, "callOnEventMethod", "onEvent");
    }  

    private static Object invokeRemoteFunction(Environment env, BObject bWebhookService, BMap<BString, Object> message,
                                               String parentFunctionName, String remoteFunctionName) {
        Future balFuture = env.markAsync();
        Module module = ModuleUtils.getModule();
        StrandMetadata metadata = new StrandMetadata(module.getOrg(), module.getName(), module.getVersion(), 
                                                    parentFunctionName);
        Object[] args = new Object[]{message, true};
        env.getRuntime().invokeMethodAsync(bWebhookService, remoteFunctionName, null, metadata, new Callback() {
            @Override
            public void notifySuccess(Object result) {
                balFuture.complete(result);
            }

            @Override
            public void notifyFailure(BError bError) {
                BString errorMessage = fromString("service method invocation failed: " + bError.getErrorMessage());
                BError invocationError = ErrorCreator.createError(module, "ServiceExecutionError", 
                                                    errorMessage, bError, null);
                balFuture.complete(invocationError);
            }
        }, args);
        return null;
    }
}