function [Interaction,kCompound,kTarget,Did,Tid]=getdata(path,dataset)
%
% INPUT
%  path:        the path where all the files to be loaded are
%  dataset:     the dataset of interest ('nr', 'gpcr', 'ic' or 'e')
%
% OUTPUT
%  Interaction: the interaction matrix (target rows, drug columns)
%  kCompound:   pairwise similarities between drugs
%  kTarget:     pairwise similarities between targets
%  Did:         KEGG IDs of drugs
%  Tid:         KEGG IDs of targets

    % ================================================================

    %------------------%
    % Adjacency Matrix %
    %------------------%

    newData1 = importdata ([ path dataset '_admat_dgc.txt']);
    Interaction = newData1.data;

    Did = newData1.textdata(1,:);
    Did(1)=[];  % remove the first element (which is 'empty')

    Tid=newData1.textdata(:,1);
    Tid(1)=[];  % remove the first element (which is 'empty')

    % ================================================================

    %----------------------------%
    % Compound Similarity Matrix %
    %----------------------------%

    newData1 = importdata ([ path dataset '_simmat_dc.txt']);
    kCompound = newData1.data;

    % ================================================================

    %--------------------------%
    % Target Similarity Matrix %
    %--------------------------%
    newData1 = importdata ([ path dataset '_simmat_dg.txt']);
    kTarget = newData1.data;

    % ================================================================

    clear newData1
    kCompound = (kCompound + kCompound')/2;

    epsilon = .1;
    while sum(eig(kCompound) >= 0) < size(kCompound,1) || isreal(eig(kCompound))==0
        kCompound = kCompound + epsilon*eye(size(kCompound,1));
    end
    while sum(eig(kTarget) >= 0) < size(kTarget,1) || isreal(eig(kTarget))==0
        kTarget = kTarget + epsilon*eye(size(kTarget,1));
    end
end