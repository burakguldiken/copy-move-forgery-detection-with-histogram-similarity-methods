function sonuc =chiSquare ( h1 , h2 )

pay=(h1-h2).^2;

payda=h1+h2;
 
bolum=pay./payda;

bolum(isnan(bolum) | isinf(bolum))=0;

sonuc=sum(bolum);

end