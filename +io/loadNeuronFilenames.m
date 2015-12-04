function neurfns = loadNeuronFilenames(exname, neurdir)
    if nargin < 2 || isempty(neurdir)
        neurdir = fullfile('data', 'neurons');
    end

    neurfns = dir(fullfile(neurdir, [exname '*']));
    neurfns = {neurfns.name};
    neurfns = cellfun(@(fn) fullfile(neurdir, fn), neurfns, 'uni', 0);

end
