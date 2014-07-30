matplotlib on a headless server
===============================

Change the backend to `Agg` (png), `PS` (ps, eps), `PDF`, `SVG`, `Cairo` (many
formats, requires Cairo libraries), `GDK` (GIMP drawing kit, can save tiff).

To chnge the backend call `matplotlib.use()` before importing `pyplot`:

    # do this before importing pylab or pyplot
    import matplotlib
    matplotlib.use('Agg')
    import matplotlib.pyplot as plt

