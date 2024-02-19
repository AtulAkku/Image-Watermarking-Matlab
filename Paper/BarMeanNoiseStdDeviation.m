clear all
clc
X = [ 1; 2; 3 ];
Y = [ 12.605782027777778 10.465995628507235 ; ...
      12.313169750000000 10.344026902942396 ; ...
      12.309499652777777 10.337651713568297 ; ...
    ];


Z = bar(X,Y);
set(Z(1), 'Facecolor','r')
set(Z(2), 'Facecolor','b')
xticks(1:3);
xticklabels({'Haar','Daubechies','Symlet'});
xlabel( 'Wavelet Type', 'FontSize',15 )
ylabel( 'Noise Difference','FontSize',15 )
legend({'Mean', 'Standard Deviation'});
axis([0, 3, 10, 13]);