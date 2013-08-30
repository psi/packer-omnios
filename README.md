# Packer Template for OmniOS

This is a [Packer][1] template for building OmniOS Vagrant base boxes.
Currently, only VMWare boxes are built.

## Building a box

1. Clone the repository.

   ```
   % git clone https://github.com/psi/packer-omnios.git
   ```

2. Build the box.

   ```
   % make vmware
   ```

3. Add the box to Vagrant. Note that the `add-vmware` target *will*
   remove an existing vmware_desktop box called `omnios` if you have one.

   ```
   % make add-vmware
   ```

[1]: http://packer.io
[2]: https://github.com/mitchellh/packer#developing-packer
