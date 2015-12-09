
%% fit all MT RFs with ASD for a given exname

exnames = io.loadExnames();
exname = exnames{1};
fits = rf.fitExpCells(exname, '', '', 'asd'); % compare to 'asd-space'

%% visualize the first cell's RF

stim = io.loadStim(exname);
cur = fits(1);
plot.rfSingle(stim.gaborXY, cur.fit.w);

