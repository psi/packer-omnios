# Packer Template for OmniOS

Not ready for primetime just yet, but does get through most of the
install. The OmniOS installer makes judicious use of the F2 key, which
Packer does not yet support sending, so for the moment, this template
requires [my Packer branch][0], but I've submitted a [pull request][1]
upstream.

[0]: https://github.com/psi/packer/tree/add-more-special-keys
[1]: https://github.com/mitchellh/packer/pull/206
