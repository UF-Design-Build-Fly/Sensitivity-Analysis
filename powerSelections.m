function power = powerSelections(table, row)
%Given the motor spreadsheet and index, function will return power
%configuration for corresponding index/row.
%Motor Spreadsheet MUST be loaded before hand at the start of the analysis
%and passed through the function each time it is called.

%There is an ideal combination of battery, motor, propeller size, etc.. for
%each given battery voltage. This function returns all the parameters 
%necessary to construct the ideal system.
%Future work could make ideal selection more automated.
%powerSystem: systems from 3 to 6 cells.
%            Motor Name,  KV, Propeller diameter (inches), Propeller pitch (inches),
%            Voltage, RPM, Current Draw (A), Power Consumption (W),
%            Flight time (minutes), thrust (pound force), Pitch speed
%            (ft/s), Efficiency (thrust/watt)*100, battery available watt
%            hours, estimated system weight (pounds).

power = table(row,:);
end
