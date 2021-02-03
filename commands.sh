#!/bin/sh -l
cmsrel CMSSW_4_4_7
cd CMSSW_4_4_7/src
mkdir HiForest
cd HiForest
git clone -b 2011 git://github.com/cms-opendata-analyses/HiForestProducerTool.git HiForestProducer
cd HiForestProducer

echo  "### pwd ###"
pwd
echo  "### ls -l ###"
ls -l
echo "### ls /cvmfs/cms-opendata-conddb.cern.ch/ ###"
ls /cvmfs/cms-opendata-conddb.cern.ch/
