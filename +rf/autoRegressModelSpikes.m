function [YhAR, wAR] = autoRegressModelSpikes(Yh, Y, nlags)
    
    % fit model
    [X, Y] = makeLagMats(Yh, Y, nlags);    
    mdl = fitlm(X, Y);
    
    % predict
    YhAR = mdl.predict(X);
    YhAR = [Yh(1:nlags); YhAR];
    wAR = mdl.Coefficients.Estimate';

end

function [X, Y] = makeLagMats(Yh, Y, nlags)
    nlags = nlags+1;
    X = nan(numel(Y)-nlags+1, nlags+1);
    X(:,end) = Yh(nlags:end);
    for jj = 1:nlags
        X(:,jj) = Y(nlags-jj+1:end-jj+1);
    end
    Y = X(:,1);
    X = X(:,2:end);
end
