FROM docs/base:hugo
MAINTAINER Mary Anthony <mary@docker.com> (@moxiegirl)

# To get the git info for this repo
COPY . /src

COPY . /docs/content/docker-trusted-registry/

WORKDIR /docs/content

ADD touch-up.sh /docs/content/touch-up.sh
RUN /docs/content/touch-up.sh

WORKDIR /docs

# Sed to process GitHub Markdown
# 1-2 Remove comment code from metadata block
# 3 Change ](/word to ](/project/ in links
# 4 Change ](word.md) to ](/project/word)
# 5 Remove .md extension from link text
# 6 Change ](./ to ](/project/word) 
# 7 Change ](../../ to ](/project/ 
# 8 Change ](../ to ](/project/ 
# 
#RUN find /docs/content/docker-trusted-registry -type f -name "*.md" -exec sed -i.old \
#    -e '/^<!.*metadata]>/g' \
#    -e '/^<!.*end-metadata.*>/g' \
#    -e 's/\(\]\)\([(]\)\(\/\)/\1\2\/docker-trusted-registry\//g' \
#    -e 's/\(\][(]\)\([A-z].*\)\(\.md\)/\1\/docker-trusted-registry\/\2/g' \
#    -e 's/\([(]\)\(.*\)\(\.md\)/\1\2/g'  \
#    -e 's/\(\][(]\)\(\.\/\)/\1\/docker-trusted-registry\//g' \
#    -e 's/\(\][(]\)\(\.\.\/\.\.\/\)/\1\/docker-trusted-registry\//g' \
#    -e 's/\(\][(]\)\(\.\.\/\)/\1\/docker-trusted-registry\//g' {} \;
