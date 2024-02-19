clear all
clc
X = [ 1; 2; 3 ];
Y = [ 0.008877506726900 0.008796472117775 0.008683658014866; ...
      0.008573738713956 0.008492450349865 0.008379661608356; ...
      0.008568726716647 0.008488714582853 0.008375809962835; ...
    ];


Z = bar(X,Y);
set(Z(1), 'Facecolor','r')
set(Z(2), 'Facecolor','b')
set(Z(3), 'Facecolor','g')
xticks(1:3);
xticklabels({'Haar','Daubechies','Symlet'});
xlabel( 'Wavelet Type', 'FontSize',15 )
ylabel( 'MSE Values','FontSize',15 )
legend({'Red', 'Blue', 'Green'});
axis([0, 3, 0.0080, 0.0090]);