#!/bin/bash
set -x

echo "Creating user..."

GROUP="${GROUP:-}"
USER="${USER:-}"
COMMENT="${COMMENT:-}"
HOME="${HOME:-}"

if ! getent group ${GROUP} >/dev/null
then
  sudo addgroup --system ${GROUP} >/dev/null
fi

if ! getent passwd ${USER} >/dev/null
then
  sudo adduser \
    --system \
    --disabled-login \
    --ingroup ${GROUP} \
    --home ${HOME} \
    --no-create-home \
    --gecos "${COMMENT}" \
    --shell /bin/false \
    ${USER}  >/dev/null
fi

# Create & set permissions on HOME directory
sudo mkdir -pm 0755 ${HOME}
sudo chown -R ${USER}:${GROUP} ${HOME}
sudo chmod -R 0755 ${HOME}

echo "Complete"