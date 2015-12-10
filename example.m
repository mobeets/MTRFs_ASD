
%% fit all MT RFs with ASD for a given exname

exnames = io.loadExnames();
exname = exnames{1};

clear fitopts;
fitopts.fitType = 'asd';
fitopts.asdType = 'space';
fits = rf.fitExpCells(exname, '', '', fitopts);

%% visualize the first cell's RF

stim = io.loadStim(exname);
cur = fits(1);
plot.rfSingle(stim.gaborXY, cur.fit.w);

%% predict spike count for example stim

cur = fits(1);
stim = io.loadStim(cur.exname);
neur = load(cur.neurfn);
Yh = rf.predict(stim, neur, cur.fit);
Y = neur.spikeCount;
[YhAR, wAR] = rf.autoRegressModelSpikes(Yh, Y, 4);

% to pass a stimulus yourself, call:
%   Yh = rf.predict([], [], cur.fit, stim.pulses);

figure; hold on;
plot(Y, 'k');
plot(Yh, 'r');
plot(YhAR, 'b');
legend('Y', 'Yh', 'YhAR');
title([cur.exname ' - ' num2str(cur.cellid)]);

%% baseline fits

exnames = io.loadExnames();
exname = exnames{1};

clear fits; clear scs;

clear fitopts;
fitopts.fitType = 'ridge';
fitopts.fitInfo = 'baseline';
fs = rf.fitExpCells(exname, '', '', fitopts);
fits.baseline = fs;
scs.baseline = cellfun(@(f) f.score, {fs.fit});

clear fitopts;
fitopts.fitType = 'ridge';
fitopts.fitInfo = 'gaborInd'; % one gabor, uses all pulses
fitopts.gaborInd = 1;
fs = rf.fitExpCells(exname, '', '', fitopts);
fits.gaborInd = fs;
scs.gaborInd = cellfun(@(f) f.score, {fs.fit});

clear fitopts;
fitopts.fitType = 'ridge';
fitopts.fitInfo = 'gaborIndSum'; % one gabor, sums across time
fitopts.gaborInd = 1;
fs = rf.fitExpCells(exname, '', '', fitopts);
fits.gaborIndSum = fs;
scs.gaborIndSum = cellfun(@(f) f.score, {fs.fit});

%% visualize baseline model scores

close all;
figure; hold on;
fns = fieldnames(scs);
nms = cell(numel(fns),1);
for ii = 1:numel(fns)
    plot(scs.(fns{ii}));
    nms{ii} = fns{ii};
end
legend(nms);
