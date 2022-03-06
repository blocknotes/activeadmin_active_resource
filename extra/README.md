# Development

## Releases

```sh
# Update lib/activeadmin/active_resource/version.rb with the new version
# Update the gemfiles:
bin/appraisal
```

## Testing

```sh
# Running specs using a specific configuration:
bin/appraisal rails60-activeadmin22-activeresource51 rspec
# Using latest activeadmin/activeresource versions:
bin/appraisal rails60-activeadmin-activeresource rspec
# See gemfiles for more configurations
```
