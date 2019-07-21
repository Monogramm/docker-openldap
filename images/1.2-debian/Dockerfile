FROM osixia/openldap:1.2.4

ARG VERSION=1.2.4
ARG VCS_REF
ARG BUILD_DATE

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
    org.label-schema.schema-version="1.0"

# Add requirements for common extensions
ADD bootstrap /container/service/slapd/assets/config/bootstrap
RUN rm /container/service/slapd/assets/config/bootstrap/schema/mmc/mail.schema
