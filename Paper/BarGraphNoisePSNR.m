clear all
clc
X = [ 1; 2; 3; 4 ];
Y = [ 1.466861787736914 2.043761544794968 2.519878773860231; ...
      1.465637105754779 2.042463122348988 2.518519592381545; ...
      1.505616180916992 2.084841790860809 2.562899798769540; ...
      1.505631890746136 2.084858469610515 2.562917239376476; ...
    ];


Z = bar(X,Y);
set(Z(1), 'Facecolor','r')
set(Z(2), 'Facecolor','g')
set(Z(3), 'Facecolor','b')
xticks(1:4);
xticklabels({'Gaussian','Salt and Papper','Poision', 'Spekle'});
xlabel( 'Noise Type', 'FontSize',15 )
ylabel( 'PSNR values','FontSize',15 )
legend({'Red Channel', 'Green Channel', 'Blue Channel'});
axis([0, 4, 1.3, 2.6]);