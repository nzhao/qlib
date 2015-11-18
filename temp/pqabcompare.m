%% incibeampq
figure;
plot(1:length(a0),real(a0),'r-')
data1=dlmread('D:\mywork\zhoulm\OpticalTrap\FScat\SphereScat\SphereScat\05incibeampq.txt');
hold on;
aindx=find(data1(:,4));
tmp1=[data1(:,1),data1(:,4)];
tmp2=tmp1(aindx,:);
plot(1:length(aindx),tmp2(:,2),'b--')

%% incibeamab
figure;
data1=tmp;
plot(1:length(data1(:,3)),real(data1(:,3)),'r-')
data1=dlmread('D:\mywork\zhoulm\OpticalTrap\FScat\SphereScat\SphereScat\05scatbeamab.txt');
hold on;
aindx=find(data1(:,4));
tmp1=[data1(:,1),data1(:,4)];
tmp2=tmp1(aindx,:);
plot(1:length(aindx),tmp2(:,2),'b--')