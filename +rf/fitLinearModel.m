function obj = fitLinearModel(X, Y, D, fitType)
% X - [nt x nw] - stimulus
% Y - [nt x 1] - spikes
% D - [nw x nw] - squared distance matrix for features in X
% fitType (str) - one of ['ML', 'Ridge', 'ASD']
% 
% obj (struct) - model fit and scores
% 

    obj.llstr = 'gauss'; % noise model; could be 'poiss' or 'bern' as well
    obj.nfolds = 10;
    [~, obj.foldinds] = tools.trainAndTestKFolds(X, Y, obj.nfolds);

    obj.isLinReg = strcmpi(obj.llstr, 'gauss');
    scoreObj = reg.getScoreObj(obj.isLinReg);

    if strcmpi(fitType, 'ML')
        obj = reg.getObj_ML(X, Y, obj);
    elseif strcmpi(fitType, 'Ridge')
        obj = reg.getObj_ML_Ridge(X, Y, scoreObj, obj);
    elseif strcmpi(fitType, 'ASD')
        obj = reg.getObj_ASD(X, Y, D, scoreObj, obj);
    else
        error(['Unrecognized fitType: ' fitType]);
    end

    obj = reg.fitAndScore(X, Y, obj, scoreObj);

end
