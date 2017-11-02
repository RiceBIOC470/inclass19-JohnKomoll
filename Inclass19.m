%In class 19

% Problem 1. Imagine a clinical trial for two drugs that are intended to lower
% cholesterol. Assume 30 subjects are randomly divided into 3 groups that
% either receive a placebo or one of the two treatments. The mean initials
% levels of total cholesterol in each group are the same. The final
% measurements look like

placebo = [   194   183   199   189   189   214   212   186   191   190];
treatment1 = [    138   217   188   126   249   217   255   196   279   123];
treatment2 =[   152   152   151   143   161   142   142   141   161   135];

%A. Make a bar plot of the means of each group with errorbars (Hint, use
%bar and then use 'hold on' and then errorbar). 
%B. Run a one way ANOVA analysis to see whether any of the treatment groups showed
%a statistically signficant difference. 
%C. use the multcompare function to look at all pairs of samples and
%indicate which are significantly different. 

% (A)
% Get means and standard deviations
p_mean = mean(placebo);
t1_mean = mean(treatment1);
t2_mean = mean(treatment2);
p_std = std(placebo);
t1_std = std(treatment1);
t2_std = std(treatment2);

% Plot bars and error bars
labels = categorical({'Placebo','Treatment 1','Treatment 2'});
bar(labels, [p_mean, t1_mean, t2_mean])
hold on
errorbar([p_mean, t1_mean, t2_mean], [p_std, t1_std, t2_std], 'o')

% (B)
% Check for significant difference with ANOVA
labels_an = {'Placebo', 'Placebo', 'Placebo', 'Placebo', 'Placebo', 'Placebo', 'Placebo', 'Placebo', 'Placebo', 'Placebo', 'Treatment 1', 'Treatment 1', 'Treatment 1', 'Treatment 1', 'Treatment 1', 'Treatment 1', 'Treatment 1', 'Treatment 1', 'Treatment 1', 'Treatment 1', 'Treatment 2', 'Treatment 2', 'Treatment 2', 'Treatment 2', 'Treatment 2', 'Treatment 2', 'Treatment 2', 'Treatment 2', 'Treatment 2', 'Treatment 2'};
[p, table, stats] = anova1([placebo, treatment1, treatment2], labels_an);
disp(p)

% One of the groups is significantly different

% (C)
figure
multcompare(stats)

% The group Treatment2 is significantly different from the Placebo and
% Treatment1 groups.

%Problem 2. In this directory, you will find a .mat file with three
%variables, xdat, ydat, and ydat2. For each pair (xdat, ydat) and (xdat,
%ydat2), fit the data to a first, second and third order polynomial. Which
%one is the best fit in each case? In at least one of the cases, do the
%problem with both the polyfit/polyval functions and with the 'fit' function.

% Load data
data = load('data.mat');

% Fit xdat and ydat to polynomials
[coeff1, s1] = polyfit(data.xdat, data.ydat, 1);
[coeff2, s2] = polyfit(data.xdat, data.ydat, 2);
[coeff3, s3] = polyfit(data.xdat, data.ydat, 3);

% Fit xdat and ydat2 to polynomials
[coeff1_2, s1_2] = polyfit(data.xdat, data.ydat2, 1);
[coeff2_2, s2_2] = polyfit(data.xdat, data.ydat2, 2);
[coeff3_2, s3_2] = polyfit(data.xdat, data.ydat2, 3);

% Plot polynomial fits to xdat and ydat
figure
plot(data.xdat, data.ydat, 'r.', 'MarkerSize', 24)
hold on
plot(data.xdat, polyval(coeff1, data.xdat), 'k-', 'LineWidth', 2)
plot(data.xdat, polyval(coeff2, data.xdat), 'g-', 'LineWidth', 2)
plot(data.xdat, polyval(coeff3, data.xdat), 'b-', 'LineWidth', 2)

% All three polynomial fits characterize the data for xdat vs ydat fairly
% well. However, the first order polynomial is probably the best fit of the
% data, because it doesn't overcomplicate the model used to predict how
% ydat varies with xdat. The second and third order polynomial fits to this
% data have very small coefficients for the x terms of order > 1. This is
% because these terms do not describe the relationship well.

% Plot polynomial fits to xdat and ydat2
figure
plot(data.xdat, data.ydat2, 'r.', 'MarkerSize', 24)
hold on
plot(data.xdat, polyval(coeff1_2, data.xdat), 'k-', 'LineWidth', 2)
plot(data.xdat, polyval(coeff2_2, data.xdat), 'g-', 'LineWidth', 2)
plot(data.xdat, polyval(coeff3_2, data.xdat), 'b-', 'LineWidth', 2)

% The third order polynomial clearly characterizes the relationship between
% xdat and ydat2 the best. The fit line follows the data points very well.

% Now use the fit function to fit the data ydat2 to xdat.
fit_out1 = fit(data.xdat', data.ydat2', 'poly1');
fit_out2 = fit(data.xdat', data.ydat2', 'poly2');
fit_out3 = fit(data.xdat', data.ydat2', 'poly3');

% Plot the linear models generated with the fit function
figure
plot(fit_out1, data.xdat, data.ydat2)
hold on
plot(fit_out2)
plot(fit_out3)
legend({'Data', 'Fit Lines'})
set(gca, 'FontSize', 20)
