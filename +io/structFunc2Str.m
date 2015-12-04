function obj = structFunc2Str(obj)

    fns = fieldnames(obj);
    for ii = 1:numel(fns)
        fn = fns{ii};
        if isa(obj.(fn), 'struct')
            obj.(fn) = io.structFunc2Str(obj.(fn));
        elseif isa(obj.(fn), 'function_handle')
            obj.(fn) = func2str(obj.(fn));
        end        
    end

end
