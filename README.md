
    %% fit all MT RFs with ASD for a given exname

    exname = 'n20150304a';
    fits = rf.fitCells(exname);

    %% visualize the first cell's RF

    stim = io.loadStim(exname);
    cur = fits(1);
    plot.rfSingle(stim.gaborXY, cur.fit.w);
