% Code01_07  %atomic properties
% Code09_04  %cycling transition matrices
% Code09_05  %compactification
% Code09_06  %compactification
% Code09_07  %left and right quantum numbers

tAop=zeros(gpq,gpq);%initialize
for kcc=1:gpq%run through columns of matrix tAop
    pcc=p(kcc); qcc=q(kcc); lcc=lmunu(:,kcc); %pq and spin lv of starting tile
    tAop(in{kcc},in{kcc})=Nuu(lcc,lcc)/(E0+hbar*kap*pcc/te) ...
        +Ndd(lcc,lcc)/(E0-hbar*kap*pcc/te);
    pnw=pcc+1; qnw=qcc+1; %pq for northwest tile
    if pnw+qnw>2*ns;%in skew boundaries?
        pnw=pnw-(2*ns+1); qnw=qnw-(2*ns+1);%wrap
    end
    knw=find(pnw==p&qnw==q); lnw=lmunu(:,knw);%indices, lv?s of coupled tiles
    tAop(in{knw},in{kcc})=Nnw(lnw,lcc)/(E0+hbar*kap*pcc/te);
    pse=pcc-1; qse=qcc-1; %pq for southeast tile
    if abs(pse+qse)>2*ns;%in skew boundaries?
        pse=pse+(2*ns+1); qse=qse+(2*ns+1);%wrap
    end
    kse=find(pse==p&qse==q); lse=lmunu(:,kse);%indices, lv?s of coupled tiles
    tAop(in{kse},in{kcc})=Nse(lse,lcc)/(E0-hbar*kap*pcc/te);
    if fg>.5 %coupling in off-diagonal direction
        pne=pcc+1; qne=qcc-1;%pq for northeast tile
        if abs(pne-qne)<=maxpmq; %in diagonal boundaries?
            kne=find(pne==p&qne==q); lne=lmunu(:,kne);
            tAop(in{kne},in{kcc})=Nne(lne,lcc)/(E0+hbar*kap*pcc/te);
        end
        psw=pcc-1; qsw=qcc+1;%pq for southwest tile
        if abs(psw-qsw)<=maxpmq; %in diagonal boundaries?
            ksw=find(psw==p&qsw==q); lsw=lmunu(:,ksw);
            tAop(in{ksw},in{kcc})=Nsw(lsw,lcc)/(E0-hbar*kap*pcc/te);
        end
        pnn=pcc+2; qnn=qcc;%pq for north tile
        if abs(pnn-qnn)<=maxpmq%in diagonal boundaries?
            if abs(pnn+qnn)>2*ns;%in skew boundaries?
                pnn=pnn-2*ns-1; qnn=qnn-2*ns-1;
            end
            knn=find(pnn==p&qnn==q) ;lnn=lmunu(:,knn);
            tAop(in{knn},in{kcc})=Nnn(lnn,lcc)/(E0+hbar*kap*pcc/te);
        end
        pss=pcc-2; qss=qcc;%pq for south tile
        if abs(pss-qss)<=maxpmq%in diagonal boundaries?
            if abs(pss+qss)>2*ns%outside skew boundaries?
                pss=pss+2*ns+1; qss=qss+2*ns+1;
            end
            kss=find(pss==p&qss==q);lss=lmunu(:,kss);
            tAop(in{kss},in{kcc})=Nss(lss,lcc)/(E0-hbar*kap*pcc/te);
        end
    end
end
for j=1:gsm%transposition matrix
    T(:,j)=pp(j)==qq&qq(j)==pp&mmu(j)==nnu&nnu(j)==mmu;
end
Aop=tAop+conj(T*tAop*T);%add Liouville conjugate
