# Solargraph Docker image

Docker image for the Ruby language server Solargraph

## Usage

For use with the Ruby Solargraph (`castwide.solargraph`) VSCode Extension, add
the following to VSCode's settings:

`~/.config/Code/User/settings.json`:

```json
{
    "solargraph.externalServer": {
      "host": "localhost",
      "port": 7658
    }
}
```

Run the server on port `7658`:

```shell
docker run --name=solargraph-ruby --rm -d -p 7658:7658/tcp \
       -v $HOME/src/pub:$HOME/src/pub:ro \
       trinitronx/solargraph:0.55.2-ruby-3.4.4-alpine3.22
```

Note that the source code paths should match inside and outside the container.
Ensure that the `-v` volume mount paths match your source code directory.

## Sponsor

If you find this project useful and appreciate my work,
would you be willing to click one of the buttons below to Sponsor this project
and help me continue?

<!-- markdownlint-disable MD033  -->
| Method       | Button                                                                                                                               |
| :----------- | :----------------------------------------------------------------------------------------------------------------------------------: |
| GitHub       | [![💖 Sponsor](https://trinitronx.github.io/assets/img/gh-button-medium.svg)](https://github.com/sponsors/trinitronx)                                                                                 |
| Liberapay    | [![Support with Liberapay](https://liberapay.com/assets/widgets/donate.svg)](https://liberapay.com/trinitronx/donate)                |
| PayPal       | [![Support with PayPal](https://trinitronx.github.io/assets/img/paypal-button-medium-blue.svg)](https://paypal.me/JamesCuzella)              |
| Ko-Fi        | [![Support with Ko-Fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/trinitronx)                                     |
| BuyMeACoffee | [![Buy Me a Coffee](https://trinitronx.github.io/assets/img/bmc-button-medium.svg)](https://www.buymeacoffee.com/TrinitronX) |
| Polar        | [![Support with Polar](https://trinitronx.github.io/assets/img/polar-button-medium-dark.svg)](https://polar.sh/lyraphase)                   |
| Patreon <sup>(_my artist page_)</sup> | [![Support with Patreon](https://img.shields.io/badge/dynamic/json?logo=patreon&style=for-the-badge&color=ffac00&label=Patreon&query=data.attributes.patron_count&suffix=%20patrons&url=https%3A%2F%2Fwww.patreon.com%2Fapi%2Fcampaigns%2F2379189)](https://www.patreon.com/bePatron?u=16585899)                                     |
<!-- markdownlint-enable MD033  -->

Every little bit is appreciated! Thank you! 🙏
