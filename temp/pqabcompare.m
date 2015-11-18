%% incibeampq
figure;
plot(1:length(a0),real(a0),'r-')
data1=dlmread('D:\mywork\zhoulm\OpticalTrap\FScat\SphereScat\SphereScat\05incibeampq.txt');
hold on;
aindx=find(data1(:,4));
tmp1=[data1(:,1),data1(:,4)];
tmp2=tmp1(aindx,:);
plot(1:length(aindx),tmp2(:,2),'b--')

%% incibeampq
figure;
plot(1:length(a2),real(a2),'r-')
data1=dlmread('D:\mywork\zhoulm\OpticalTrap\FScat\SphereScat\SphereScat\05scatbeamab.txt');
hold on;
aindx=find(data1(:,4));
tmp1=[data1(:,1),data1(:,4)];
tmp2=tmp1(aindx,:);
plot(1:length(aindx),-tmp2(:,2),'b--')