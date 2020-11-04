# SRCMF
Identifying the potential drug-target interactions (DTI) is critical in drug discovery. The drug-target interac-tion prediction methods based on collaborative filtering have demonstrated attractive prediction performance. However, many corresponding models cannot accurately express the relationship between similarity features and DTI features. In order to rationally represent the correlation, we propose a novel matrix factorization method, so-called collaborative matrix factorization with soft regularization (SRCMF). SRCMF improves the prediction performance by combining the drug and target similarity information with matrix factorization. In contrast to general collaborative matrix factorization, the fundamental idea of SRCMF is to make the sim-ilarity features and the potential features of DTI approximate, not exactly identical. Specifically, SRCMF obtains low rank feature representations of drug similarity and target similarity, and then uses a soft regular-ization term to constrain the approximation between drug (target) similarity features and drug (target) poten-tial features of DTI. To comprehensively evaluate the prediction performance of SRCMF, we conduct cross-validation experiments under three different settings. In terms of AUPR value, SRCMF achieves better prediction results than six state-of-the-art methods. In addition, under different noise levels of similarity data, the prediction performance of SRCMF is much better than collaborative matrix factorization. In conclusion, SRCMF is robust leading to performance improvement in drug-target interaction prediction.

# Requirements
* Matlab >= 2014

# Installation
SRCMF can be downloaded by
```
git clone https://github.com/BioinformaticsCSU/SRCMF
```
Installation has been tested in a Windows platform.

# Dataset Description
* Did: the KEGG IDs of drugs;
* Tid: the KEGG IDs of targets;
* Dataset Enzyme:
```
e_admat_dgc.txt: target-drug interaction matrix.
e_simmat_dc.txt: drug similarity matrix;
e_simmat_dg.txt: target similarity matrix;
```   
* Dataset Ion channel:
```
ic_admat_dgc.txt: target-drug interaction matrix.
ic_simmat_dc.txt: drug similarity matrix;
ic_simmat_dg.txt: target similarity matrix;
``` 
* Dataset GPCR:
```
gpcr_admat_dgc.txt: target-drug interaction matrix.
gpcr_simmat_dc.txt: drug similarity matrix;
gpcr_simmat_dg.txt: target similarity matrix;
``` 
* Dataset Nuclear Receptors:
```
nr_admat_dgc.txt: target-drug interaction matrix.
nr_simmat_dc.txt: drug similarity matrix;
nr_simmat_dg.txt: target similarity matrix;
``` 

# Functions Description
* ```alg_srcmf_predict.m```: This function can implement SRCMF.
* ```calculate_auc.m```: This function is used to calculate the AUC value.
* ```calculate_aupr.m```: This function is used to calculate the AUPR value.
* ```crossValidation.m and nfold.m```: These function are used in cross validation test.
* ```get_folds.m```: This function is used to obtain the data of each fold.
* ```get_test_indices.m```: This function can get the index of test set data.
* ```getdata.m```: This function is used to read data.
* ```initializer.m```: The function can be decomposed by SVD.
* ```returnEvaluationMetrics.m```: This function is used to return the evaluation indicators.
* ```RUN_Cross_Validation.m```: The start function of ten fold cross validation test.
* ```start_grid_search.m```: The function realizes the grid search function of parameters.

# Instructions
We provide detailed step-by-step instructions for running SRCMF model.

**Step 1**: add datasets\functions paths and name
```
path='data\';
datasets='gpcr';
```
**Step 2**: load datasets with association matirx and similarity matrices
```
[Y,Sd,St,Did,Tid]=getdata(path,datasets);
```
**Step 3**: parameter Settings

The hyper-parameters are fixed.
```
epsilon = 0.01;
iter = 10;
```
the parameters: arbitrarily given(The best parameters can be obtained by grid search)
```
k=20;
lambda_l=2;
lambda_d=1;
lambda_t=1;
```
**Step 4**: get projection matrix W
```
W = ones(size(Y));
W(Y == 0) = 0;
```
**Step 5**: run alg_srcmf_predict function (alg_srcmf_predict.m), The complete drug-target interaction matrix 'y_recovery' is obtained
```
y_recovery = alg_srcmf_predict(Y,Sd,St,k,lambda_l,lambda_d,lambda_t,W);
```

# A Quickstart Guide
Users can immediately start playing with SRCMF running ```demo_SRCMF.m``` in matlab.
* ```demo_SRCMF.m```: it demonstrates a process of predicting drug-target interactions on the gold standard dataset (GPCR) by SRCMF algorithm.

# Contact
If you have any questions or suggestions with the code, please let us know. 
Contact Ligang Gao at ```ligang_gao@csu.edu.cn```
