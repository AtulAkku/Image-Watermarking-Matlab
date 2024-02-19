clear all
clc
X = [ 1; 2; 3 ];
Y = [ 68.647893508089910 68.687718304199250 68.743776493997930; ...
      68.799101166846740 68.840473443711770 68.898538797783370; ...
      68.801640688183780 68.842384293799950 68.900535457105500; ...
    ];


Z = bar(X,Y);
set(Z(1), 'Facecolor','r')
set(Z(2), 'Facecolor','b')
set(Z(3), 'Facecolor','g')
xticks(1:3);
xticklabels({'Haar','Daubechies','Symlet'});
xlabel( 'Wavelet Type', 'FontSize',15 )
ylabel( 'PSNR Values','FontSize',15 )
legend({'Red', 'Blue', 'Green'});
axis([0, 3, 68, 69]);