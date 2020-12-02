FROM osixia/openldap:1.3.0

ARG VERSION=1.3.0
ARG VCS_REF
ARG BUILD_DATE

# Container labels (http://label-schema.org/)
# Container annotations (https://github.com/opencontainers/image-spec)
LABEL maintainer="Monogramm Maintainers <opensource at monogramm dot io>" \
    version=$VERSION \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/Monogramm/docker-openldap" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="OpenLDAP - community developed LDAP software" \
    org.label-schema.description="Open Source implementation of the Lightweight Directory Access Protocol (LDAP)." \
    org.label-schema.url="http://www.openldap.org/" \
    org.label-schema.vendor="OpenLDAP Foundation" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0" \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.source="https://github.com/Monogramm/docker-openldap" \
    org.opencontainers.image.created=$BUILD_DATE \
    org.opencontainers.image.title="OpenLDAP - community developed LDAP software" \
    org.opencontainers.image.description="Open Source implementation of the Lightweight Directory Access Protocol (LDAP)." \
    org.opencontainers.image.url="http://www.openldap.org/" \
    org.opencontainers.image.vendor="OpenLDAP Foundation" \
    org.opencontainers.image.version=$VERSION \
    org.opencontainers.image.authors="Monogramm maintainers <opensource at monogramm dot io>"

# Add requirements for common extensions
ADD bootstrap /container/service/slapd/assets/config/bootstrap
RUN rm /container/service/slapd/assets/config/bootstrap/schema/mmc/mail.schema
