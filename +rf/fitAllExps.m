
% fit all exnames
exnames = io.loadExnames();
fits = struct([]);
for ii = 1:numel(exnames)
    exname = exnames{ii};
    fs = rf.fitExpCells(exname);
    fits = [fits fs];    
end

% remove all function handles
for ii = 1:numel(fits)
    fits(ii) = io.structFunc2Str(fits(ii));
end

% save
dtstr = datestr(datetime, 30);
outfile = fullfile('data', 'fits', [dtstr '.mat']);
save(outfile, 'fits', 'dtstr');
