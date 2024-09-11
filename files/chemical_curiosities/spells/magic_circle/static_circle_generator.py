from PIL import Image
import numpy as np

mask = np.array(Image.open("C:/Program Files (x86)/Steam/steamapps/common/Noita/mods/Hydroxide/files/chemical_curiosities/spells/magic_circle/target.png")).clip(0, 1)[:,:,:3]
rng = np.random.default_rng()
img = rng.integers(0, 256, (120, 120, 3), dtype=np.uint8)
img[:,:,0] = 0
img[:,:,2] = 0
masked = img * mask
print(masked.shape, masked.dtype)
Image.fromarray(masked).save("./out.png")