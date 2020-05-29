#!/bin/bash

# Clean up needed repos and folders
rm -dfr ./obj && rm -dfr ./_site && rm -dfr ./code-examples/dotnet-client && rm -dfr ./code-examples/jvm-client

# mkdir ../EventStore
# mkdir ../EventStore.Samples.Dotnet
# mkdir ../es-docs-template
# mkdir ../EventStore.Samples.Java

# Update all needed repos
# git -C ../EventStore checkout -b version5 oss-v5.0.8
# git -C ../EventStore.Samples.Dotnet pull origin master
# git -C ../es-docs-template pull origin master
# git -C ../EventStore.Samples.Java pull origin master

git clone --recurse-submodules -b oss-v5.0.8 git@github.com:EventStore/EventStore.git ../EventStore
git clone git@github.com:EventStore/EventStore.Samples.Dotnet.git ../EventStore.Samples.Dotnet
git clone git@github.com:EventStore/es-docs-template.git ../es-docs-template
git clone git@github.com:EventStore/EventStore.Samples.Java.git ../EventStore.Samples.Java

# Move example files needed
mkdir ./code-examples/dotnet-client && mkdir ./code-examples/jvm-client

cp ../EventStore.Samples.Dotnet/DocsExample/Program.cs ./code-examples/dotnet-client/
cp ../EventStore.Samples.Java/src/main/java/org/eventstore/sample/*.java ./code-examples/jvm-client/

docfx metadata

# TODO: Clone theme

docfx build docfx.json --force

# TODO: To GitHub?

# Minify
minify -o ../eventstore.com/docs/styles ../eventstore.com/docs/styles

# Tidy up
rm -dfr ../EventStore
rm -dfr ../EventStore.Samples.Dotnet
rm -dfr ../es-docs-template
rm -dfr ../EventStore.Samples.Java