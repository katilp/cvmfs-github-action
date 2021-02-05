#!/bin/sh -l

echo $SHELL
echo "### whomai ###"
whoami
echo "### ls -l / ###"
ls -l /
echo "### ls -l /cvmfs/cms.cern.ch/ ###"
ls -l  /cvmfs/cms.cern.ch/
echo "### ls -l /cvmfs/cms.cern.ch/cmsset_default.sh ###"
ls -l  /cvmfs/cms.cern.ch/cmsset_default.sh
echo "### cat $HOME/.bashrc ###"
cat $HOME/.bashrc
echo "### cat /cvmfs/cms.cern.ch/cmsset_default.sh ###"
cat /cvmfs/cms.cern.ch/cmsset_default.sh
echo "### Check ii cmenv and  cmsrel command work ###"
cmsenv
cmsrel CMSSW_4_4_7
echo "### Do again source /cvmfs/cms.cern.ch/cmsset_default.sh ###"
# This should have been all done at the start-up according to the message, but doing it again
source /cvmfs/cms.cern.ch/cmsset_default.sh
echo "### Check again cmsenv and cmsrel ###"
# These two give an error message:
cmsenv
cmsrel CMSSW_4_4_7
echo "### set them explicitly with scramv1 ###"
# Use explicit scramv1 commands instead:
eval `scramv1 runtime -sh`
scramv1 project CMSSW CMSSW_4_4_7
cd CMSSW_4_4_7/src
mkdir HiForest
cd HiForest
git clone -b 2011 git://github.com/cms-opendata-analyses/HiForestProducerTool.git HiForestProducer
cd HiForestProducer

scram b -j8

if [ -z "$1" ]; then nev=100; else nev=$1; fi
if [ -z "$2" ]; then config=hiforestanalyzer_cfg.py; else config=$2; fi
# set the number of events
eventline=$(grep maxEvents $config)
sed -i "s/$eventline/process.maxEvents = cms.untracked.PSet( input = cms.untracked.int32($nev) )/g" $config
# remove the connection to cvmfs, for GT access from docker container  
# sed -i "s/process.GlobalTag.connect/#process.GlobalTag.connect/g" $config
cmsRun $config

echo  "### pwd ###"
pwd
echo  "### ls -l ###"
ls -l
