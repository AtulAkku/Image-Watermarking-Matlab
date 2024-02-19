clear all
clc
X = [ 1; 2; 3; 4 ];
Y = [ 4.638677526384940e+04 4.061665989439338e+04 3.639925404816574e+04; ...
      4.639985787504644e+04 4.062880498704895e+04 3.641064745435706e+04; ...
      4.597468293217589e+04 4.023427516688460e+04 3.604046461071434e+04; ...
      4.597451662725202e+04 4.023412065050354e+04 3.604031987797167e+04; ...
    ];

Z = bar(X,Y);
set(Z(1), 'Facecolor','r')
set(Z(2), 'Facecolor','g')
set(Z(3), 'Facecolor','b')
xticks(1:4);
xticklabels({'Gaussian','Salt and Papper','Poision', 'Spekle'});
xlabel( 'Noise Type', 'FontSize',15 )
ylabel( 'MSE values','FontSize',15 )
legend({'Red Channel', 'Green Channel', 'Blue Channel'});
axis([0, 4, 3.5e+04, 4.7e+04]);