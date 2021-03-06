function score = MC( data )
uids = data(:,1);
mids = data(:,2);
ratings = data(:,3);

Nr = max(data(:,2)); %movies
Nc = max(data(:,1));  %users
A = zeros(Nr, Nc);

for in=1:length(ratings)
  A(mids(in),uids(in)) = ratings(in);
end

pattern = 10;
lambda = 0.01;
maxIter = 5;

% randomly initialize H and W matrices
Hinit = rand(Nr,pattern);
Winit = rand(Nc,pattern);


%SGD:
k=1;
for i = 1:maxIter
  ak = 0.01/k^(1/2);
  for inr=1:Nr
      for inc=1:Nc
        if A(inr,inc) ~= 0 
          Aij = A(inr,inc); 
          Hold = Hinit(inr,:); 
          Wold = Winit(inc,:);
          
          tk = dot(Hold,  Wold) - Aij;

          Hnew =  Hold - ak .* (tk .*  Wold + lambda .*  Hold);
          Wnew =  Wold - ak .* (tk .*  Hold + lambda .*  Wold);
       
          Winit(inc,:) = Wnew;
          Hinit(inr,:) = Hnew;
          k = k+1;
        end
      end %col
      %if mod(inr, 30)==0
      %   Apre = Hinit*transpose(Winit);
      %   rsme = calcRSME(Apre, data);
      %    
      %   fprintf('%f %f\n', abs(tk), rsme);
      %   fflush(stdout);
      %end
  end %row
end % iter

score = Hinit*transpose(Winit);
score = score';

end

